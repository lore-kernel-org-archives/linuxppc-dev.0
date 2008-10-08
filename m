Return-Path: <eemingliu@hotmail.com>
Received: from col0-omc1-s3.col0.hotmail.com (col0-omc1-s3.col0.hotmail.com
	[65.55.34.13]) by ozlabs.org (Postfix) with ESMTP id BDC2FDDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 00:52:38 +1100 (EST)
Message-ID: <COL107-W38E2468E159F1CBB304906B23B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_71988eab-273a-453a-9881-7ea86234c170_"
From: MingLiu <eemingliu@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux driver for Xilinx ICAP
Date: Wed, 8 Oct 2008 13:47:33 +0000
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_71988eab-273a-453a-9881-7ea86234c170_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear all,
Has someone manage to use the driver for the Xilinx xps_hwicap core to reconfigure bitstreams? I have enabled the driver in Linux configuration (version 2.6.24 from Xilinx tree). However I failed to use it to reconfigure bitstreams. The operations are listed as follows:
 
# cp partial.bit /dev/icap0#
 
No error information is shown, however the partial bitstream is not successfully configured. I checked /proc/devices and the device "icap" has been successfully registered with the major of 259. But in /proc/interrupts, I didn't find any matching entry of the interrupt for icap core. I tried to reconfigure the PR module with JTAG, and my design works well. 
 
Any hints for this problem? Is the problem on the interrupt? Thanks so much if someone can help me. 
 
BR
Ming
_________________________________________________________________
用手机MSN聊天写邮件看空间，无限沟通，分享精彩！
http://mobile.msn.com.cn/
--_71988eab-273a-453a-9881-7ea86234c170_
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
Dear all,<BR>
Has someone manage to use the driver for the Xilinx xps_hwicap core to reconfigure bitstreams? I have enabled the driver in Linux configuration (version 2.6.24 from Xilinx tree). However I failed to use it to reconfigure bitstreams. The operations are listed as follows:<BR>
&nbsp;<BR>
# cp partial.bit /dev/icap0<BR>#<BR>
&nbsp;<BR>
No error information is shown, however the partial bitstream is not successfully configured. I checked /proc/devices and the device "icap" has been successfully registered with the major of 259. But in /proc/interrupts, I didn't find any matching entry of the interrupt for icap core. I tried to reconfigure the PR module with JTAG, and my design works well. <BR>
&nbsp;<BR>
Any hints for this problem? Is the problem on the interrupt? Thanks so much if someone can help me. <BR>
&nbsp;<BR>
BR<BR>
Ming<BR><br /><hr />Windows Live Writer，支持离线撰写博客内容，随时随地想写就写。 <a href='http://get.live.cn/product/writer.html' target='_new'>立即使用！</a></body>
</html>
--_71988eab-273a-453a-9881-7ea86234c170_--
