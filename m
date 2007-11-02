Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s11.bay0.hotmail.com (bay0-omc2-s11.bay0.hotmail.com
	[65.54.246.147]) by ozlabs.org (Postfix) with ESMTP id 164B1DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 20:35:39 +1100 (EST)
Message-ID: <BAY138-W115999F26653FF237E2847B28D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_bc9dc07e-03a5-45d0-96d4-e5320251c462_"
From: MingLiu <eemingliu@hotmail.com>
To: "Mead, Joseph" <mead@bnl.gov>, <linuxppc-embedded@ozlabs.org>
Subject: RE: 
Date: Fri, 2 Nov 2007 09:35:38 +0000
In-Reply-To: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC59788F@exchangemb3.bnl.gov>
References: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC59788F@exchangemb3.bnl.gov>
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

--_bc9dc07e-03a5-45d0-96d4-e5320251c462_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Joe,
I don't think you can do 64 bit transfer at once because ppc405 is a 32-bit CPU. So we have to the transfer in twice. 
 
BR
Ming


Date: Thu, 1 Nov 2007 14:18:07 -0400From: mead@bnl.govTo: linuxppc-embedded@ozlabs.orgSubject: 




I am using a Xilinx ML403 board and created a custom IP that connects to the PLB bus.   The PLB bus is 64 bits wide.   To communicate with the custom IP I have been using iowrite32() and ioread32() function calls to grab 32 bits at a time.  Is it possible to grab the full 64 bits in one transfer?   I don’t see an iowrite64() or ioread64() function…
 
Thanks,Joe 
 
 
_________________________________________________________________
用 Live Search 搜尽天下资讯！
http://www.live.com/?searchOnly=true
--_bc9dc07e-03a5-45d0-96d4-e5320251c462_
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
<BR>Hi Joe,<BR>
I don't think you can do 64 bit transfer at once because ppc405 is a 32-bit CPU. So we have to the transfer in twice. <BR>
&nbsp;<BR>
BR<BR>
Ming<BR><BR>
<BLOCKQUOTE>
<HR>
Date: Thu, 1 Nov 2007 14:18:07 -0400<BR>From: mead@bnl.gov<BR>To: linuxppc-embedded@ozlabs.org<BR>Subject: <BR><BR>
<META content="Microsoft SafeHTML" name=Generator>
<STYLE>
.ExternalClass EC_p.MsoNormal, .ExternalClass EC_li.MsoNormal, .ExternalClass EC_div.MsoNormal
{margin-bottom:.0001pt;font-size:12.0pt;font-family:'Times New Roman';}
.ExternalClass a:link, .ExternalClass EC_span.MsoHyperlink
{color:blue;text-decoration:underline;}
.ExternalClass a:visited, .ExternalClass EC_span.MsoHyperlinkFollowed
{color:purple;text-decoration:underline;}
.ExternalClass EC_span.EmailStyle17
{font-family:Arial;color:windowtext;}
@page Section1
{size:8.5in 11.0in;}
.ExternalClass EC_div.Section1
{page:Section1;}

</STYLE>

<DIV class=EC_Section1>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am using a Xilinx ML403 board and created a custom IP that connects to the PLB bus. &nbsp;&nbsp;The PLB bus is 64 bits wide.&nbsp;&nbsp; To communicate with the custom IP I have been using iowrite32() and ioread32() function calls to grab 32 bits at a time. &nbsp;Is it possible to grab the full 64 bits in one transfer?&nbsp; &nbsp;I don’t see an iowrite64() or ioread64() function…</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks,<BR>Joe </SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face="Times New Roman" size=3><SPAN style="FONT-SIZE: 12pt">&nbsp;</SPAN></FONT></P></DIV></BLOCKQUOTE><br /><hr />使用新一代 Hotmail，更强大、更安全、更多存储空间！ <a href='http://mail.live.com' target='_new'>立刻体验！</a></body>
</html>
--_bc9dc07e-03a5-45d0-96d4-e5320251c462_--
