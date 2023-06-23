<?xml version="1.0" encoding="UTF-8"?>

<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
    <channel>
        <atom:link href="%($base_url^$req_path%)" rel="self" type="application/rss+xml" />
        <title><![CDATA[%($siteTitle%)]]></title>
        <link>%($base_url^$req_path%)</link>
        <description><![CDATA[%($blogDesc%)]]></description>
        <generator><![CDATA[werc-rssfy]]></generator>
        <lastBuildDate>%(`{ndate -m `{date `{mtime $rssfy_root | awk '{print $1}'}}}%)></lastBuildDate>
        <language>en-us</language>
%{
        d=$rssfy_root
        for(i in `{du -a $d^*/ $d^*.md $d^*.html $d^*.txt >[2]/dev/null | awk '{print $2}' | sed 's,//,/,g' | sed $dirfilter}) {
           if (test -f $i) {
                rf=`{echo $i | awk -F$d '{print $2}'}
                rfbn=`{echo $rf | sed 's/\///' | sed 's/\..*//'}

                title=`{echo $rfbn | sed 's/\// - /'}
                pubdate=`{ndate -m `{date `{mtime $i | awk '{print $1}'}}}

                # boldly assume we want https and rewrite werc http address
                link=`{echo $base_url | sed 's/http/https/' | sed 's/:80//'}^$rssfy_base_uri^$rfbn
%}
            <item>
                <title><![CDATA[%($title%)]]></title>
                <description><![CDATA[%($title%)]]></description>
                <link>%($link%)</link>
                <guid isPermaLink="true">%($link%)</guid>
                <pubDate>%($pubdate%)</pubDate>
            </item>

%           }
%       }
    </channel>
</rss>
