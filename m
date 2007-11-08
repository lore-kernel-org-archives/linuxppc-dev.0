Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s27.bay0.hotmail.com (unknown [65.54.246.99])
	by ozlabs.org (Postfix) with ESMTP id 7CB1FDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 21:32:19 +1100 (EST)
Message-ID: <BAY138-W3232BA0AE8C193E22B5011B28B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_b41d1478-4732-4d4d-9a4e-1128ead6936c_"
From: MingLiu <eemingliu@hotmail.com>
To: kentaro <kentaro@triumf.ca>, <linuxppc-embedded@ozlabs.org>
Subject: RE: ML405 gigabit ethernet with kernel 2.6.23
Date: Thu, 8 Nov 2007 10:32:17 +0000
In-Reply-To: <4732719A.20707@triumf.ca>
References: <4732719A.20707@triumf.ca>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_b41d1478-4732-4d4d-9a4e-1128ead6936c_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear Kentaro,
> -------------------------------------------------------------> "netperf -H 192.168.1.1 -t TCP_STREAM" 110 Mbps> "netperf -H 192.168.1.1 -t UDP_STREAM" 210 Mbps> -------------------------------------------------------------
Are these results the ones with or without Jumbo-frame enabled? If no, they are quite good I think. The results from Montavista probably are the ones with Jumbo-frame enabled. 
 
For anybody who has interest on this topic, I have recently an accepted paper which has part of the content on this. The link is http://web.it.kth.se/~mingliu/publications/co_design(icfpt07).pdf and in 6.2 section, I listed our measurement results. 300Mbps for TCP and 400Mbps for UDP, with Jumbo-frame enabled. Unfortunately I did not explain the details and detailed configurations on our case. So these results are only for your reference.
 
BR
Ming
_________________________________________________________________
Windows Live Spaces 中最年轻的成员！
http://miaomiaogarden2007.spaces.live.com/
--_b41d1478-4732-4d4d-9a4e-1128ead6936c_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>
Dear Kentaro,<BR>
<BR>&gt; -------------------------------------------------------------<BR>&gt; "netperf -H 192.168.1.1 -t TCP_STREAM" 110 Mbps<BR>&gt; "netperf -H 192.168.1.1 -t UDP_STREAM" 210 Mbps<BR>&gt; -------------------------------------------------------------<BR><BR>
Are these results the ones with or without Jumbo-frame enabled? If no, they are quite good I think. The results from Montavista probably are the ones with Jumbo-frame enabled. <BR>
&nbsp;<BR>
For anybody who has interest on this topic, I have recently an accepted paper which has part of the content on this. The link is <A href="http://web.it.kth.se/~mingliu/publications/co_design(icfpt07).pdf">http://web.it.kth.se/~mingliu/publications/co_design(icfpt07).pdf</A>&nbsp;and in 6.2 section, I listed our measurement results. 300Mbps for TCP and 400Mbps for UDP, with Jumbo-frame enabled. Unfortunately I did not explain the details and detailed configurations on our case. So these results are only for your reference.<BR>
&nbsp;<BR>
BR<BR>
Ming<BR><br /><hr />用 Windows Live Spaces 展示个性自我，与好友分享生活！  <a href='http://spaces.live.com/?page=HP' target='_new'>了解更多信息！</a></body>
</html>
--_b41d1478-4732-4d4d-9a4e-1128ead6936c_--
