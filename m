Return-Path: <eemingliu@hotmail.com>
Received: from col0-omc1-s8.col0.hotmail.com (col0-omc1-s8.col0.hotmail.com
	[65.55.34.18]) by ozlabs.org (Postfix) with ESMTP id A9C54DDF2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 01:47:56 +1100 (EST)
Message-ID: <COL107-W13F1CD2E656CAB97C189C9B23B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_8c59598d-386b-41f8-8e87-8c6583791a40_"
From: MingLiu <eemingliu@hotmail.com>
To: John Linn <john.linn@xilinx.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: Linux driver for Xilinx ICAP
Date: Wed, 8 Oct 2008 14:47:55 +0000
In-Reply-To: <20081008143431.326B3E1806A@mail96-sin.bigfish.com>
References: <COL107-W38E2468E159F1CBB304906B23B0@phx.gbl>
	<20081008143431.326B3E1806A@mail96-sin.bigfish.com>
MIME-Version: 1.0
Cc: Stephen Neuendorffer <stephenn@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_8c59598d-386b-41f8-8e87-8c6583791a40_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear John,
Nice to hear from you. If possible, could you please show me your .mhs file concerning to the xps_hwicap core? Mine is listed as below:
 
BEGIN xps_hwicap PARAMETER INSTANCE = xps_hwicap_0 PARAMETER HW_VER = 1.00.a PARAMETER C_BASEADDR = 0x40200000 PARAMETER C_HIGHADDR = 0x4020FFFF BUS_INTERFACE SPLB = plb PORT IP2INTC_Irpt = xps_hwicap_0_IP2INTC_IrptEND
 
The interrupt signal is connected to the interrupt controller. 
 
I suspect that the driver in Linux doesn't support interrupt mode for this core, since I didn't find interrupt handler registration function in the source code, like "request_irq", etc.. 
 
I will appreciate if you can have some comments to me. 
 
Br
Ming
 



Subject: RE: Linux driver for Xilinx ICAPDate: Wed, 8 Oct 2008 08:34:28 -0600From: John.Linn@xilinx.comTo: eemingliu@hotmail.com; linuxppc-embedded@ozlabs.orgCC: stephenn@xilinx.com






Hi Ming,
 
I’m copying our local expert on this core to see his thoughts as I don’t actively use this core myself.
 
Thanks,
John
 





From: linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org [mailto:linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org] On Behalf Of MingLiuSent: Wednesday, October 08, 2008 7:48 AMTo: linuxppc-embedded@ozlabs.orgSubject: Linux driver for Xilinx ICAP
 
Dear all,Has someone manage to use the driver for the Xilinx xps_hwicap core to reconfigure bitstreams? I have enabled the driver in Linux configuration (version 2.6.24 from Xilinx tree). However I failed to use it to reconfigure bitstreams. The operations are listed as follows: # cp partial.bit /dev/icap0# No error information is shown, however the partial bitstream is not successfully configured. I checked /proc/devices and the device "icap" has been successfully registered with the major of 259. But in /proc/interrupts, I didn't find any matching entry of the interrupt for icap core. I tried to reconfigure the PR module with JTAG, and my design works well.  Any hints for this problem? Is the problem on the interrupt? Thanks so much if someone can help me.  BRMing



Windows Live Writer，支持离线撰写博客内容，随时随地想写就写。 立即使用！This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately. 
_________________________________________________________________
Windows Live Photo gallery 数码相机的超级伴侣，轻松管理和编辑照片，还能制作全景美图！
http://get.live.cn/product/photo.html
--_8c59598d-386b-41f8-8e87-8c6583791a40_
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
Dear John,<BR>
Nice to hear from you. If possible, could you please show me your .mhs file concerning to the xps_hwicap core? Mine is listed as below:<BR>
&nbsp;<BR>
BEGIN xps_hwicap<BR>&nbsp;PARAMETER INSTANCE = xps_hwicap_0<BR>&nbsp;PARAMETER HW_VER = 1.00.a<BR>&nbsp;PARAMETER C_BASEADDR = 0x40200000<BR>&nbsp;PARAMETER C_HIGHADDR = 0x4020FFFF<BR>&nbsp;BUS_INTERFACE SPLB = plb<BR>&nbsp;PORT IP2INTC_Irpt = xps_hwicap_0_IP2INTC_Irpt<BR>END<BR>
&nbsp;<BR>
The interrupt signal is connected to the interrupt controller. <BR>
&nbsp;<BR>
I suspect that the driver in Linux doesn't support interrupt mode for this core, since I didn't find interrupt handler registration function in the source code, like "request_irq", etc.. <BR>
&nbsp;<BR>
I will appreciate if you can have some comments to me. <BR>
&nbsp;<BR>
Br<BR>
Ming<BR>
<BR><BR>&nbsp;<BR>

<HR>
<BR>
Subject: RE: Linux driver for Xilinx ICAP<BR>Date: Wed, 8 Oct 2008 08:34:28 -0600<BR>From: John.Linn@xilinx.com<BR>To: eemingliu@hotmail.com; linuxppc-embedded@ozlabs.org<BR>CC: stephenn@xilinx.com<BR><BR><BR>
<META content="Microsoft SafeHTML" name=Generator>
<STYLE>
.ExternalClass .EC_shape
{;}
</STYLE>

<STYLE>
.ExternalClass p.EC_MsoNormal, .ExternalClass li.EC_MsoNormal, .ExternalClass div.EC_MsoNormal
{margin-bottom:.0001pt;font-size:12.0pt;font-family:SimSun;}
.ExternalClass a:link, .ExternalClass span.EC_MsoHyperlink
{color:blue;text-decoration:underline;}
.ExternalClass a:visited, .ExternalClass span.EC_MsoHyperlinkFollowed
{color:blue;text-decoration:underline;}
.ExternalClass p
{margin-right:0in;margin-left:0in;font-size:12.0pt;font-family:SimSun;}
.ExternalClass span.EC_EmailStyle18
{font-family:Arial;color:navy;}
@page Section1
{size:8.5in 11.0in;}
.ExternalClass div.EC_Section1
{page:Section1;}

</STYLE>

<DIV class=EC_Section1>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">Hi Ming,</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">I’m copying our local expert on this core to see his thoughts as I don’t actively use this core myself.</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">Thanks,</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">John</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<DIV style="BORDER-RIGHT: medium none; PADDING-RIGHT: 0in; BORDER-TOP: medium none; PADDING-LEFT: 4pt; PADDING-BOTTOM: 0in; BORDER-LEFT: blue 1.5pt solid; PADDING-TOP: 0in; BORDER-BOTTOM: medium none">
<DIV>
<DIV class=EC_MsoNormal style="TEXT-ALIGN: center" align=center><FONT face=SimSun size=3><SPAN style="FONT-SIZE: 12pt">
<HR align=center width="100%" SIZE=2>
</SPAN></FONT></DIV>
<P class=EC_MsoNormal><B><FONT face=Tahoma size=2><SPAN style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">From:</SPAN></FONT></B><FONT face=Tahoma size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"> linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org [mailto:linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org] <B><SPAN style="FONT-WEIGHT: bold">On Behalf Of </SPAN></B>MingLiu<BR><B><SPAN style="FONT-WEIGHT: bold">Sent:</SPAN></B> Wednesday, October 08, 2008 7:48 AM<BR><B><SPAN style="FONT-WEIGHT: bold">To:</SPAN></B> linuxppc-embedded@ozlabs.org<BR><B><SPAN style="FONT-WEIGHT: bold">Subject:</SPAN></B> Linux driver for Xilinx ICAP</SPAN></FONT></P></DIV>
<P class=EC_MsoNormal><FONT face=SimSun size=3><SPAN style="FONT-SIZE: 12pt">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal style="MARGIN-BOTTOM: 12pt"><FONT face=Tahoma size=1><SPAN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">Dear all,<BR>Has someone manage to use the driver for the Xilinx xps_hwicap core to reconfigure bitstreams? I have enabled the driver in Linux configuration (version 2.6.24 from Xilinx tree). However I failed to use it to reconfigure bitstreams. The operations are listed as follows:<BR>&nbsp;<BR># cp partial.bit /dev/icap0<BR>#<BR>&nbsp;<BR>No error information is shown, however the partial bitstream is not successfully configured. I checked /proc/devices and the device "icap" has been successfully registered with the major of 259. But in /proc/interrupts, I didn't find any matching entry of the interrupt for icap core. I tried to reconfigure the PR module with JTAG, and my design works well. <BR>&nbsp;<BR>Any hints for this problem? Is the problem on the interrupt? Thanks so much if someone can help me. <BR>&nbsp;<BR>BR<BR>Ming</SPAN></FONT></P>
<DIV class=EC_MsoNormal style="TEXT-ALIGN: center" align=center><FONT face=Tahoma size=1><SPAN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">
<HR align=center width="100%" SIZE=2>
</SPAN></FONT></DIV>
<P class=EC_MsoNormal><FONT face=Tahoma size=1><SPAN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">Windows Live Writer</SPAN></FONT><FONT size=1><SPAN lang=ZH-CN style="FONT-SIZE: 9pt">，支持离线撰写博客内容，随时随地想写就写。</SPAN></FONT><FONT face=Tahoma size=1><SPAN lang=ZH-CN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"> </SPAN></FONT><FONT face=Tahoma size=1><SPAN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><A href="http://get.live.cn/product/writer.html" target=_blank><FONT face=SimSun><SPAN lang=ZH-CN style="FONT-FAMILY: SimSun">立即使用！</SPAN></FONT></A></SPAN></FONT></P></DIV></DIV><BR clear=all>This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately. <br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://messenger.live.cn/' target='_new'>立即体验！</a></body>
</html>
--_8c59598d-386b-41f8-8e87-8c6583791a40_--
