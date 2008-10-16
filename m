Return-Path: <eemingliu@hotmail.com>
Received: from col0-omc1-s5.col0.hotmail.com (col0-omc1-s5.col0.hotmail.com
	[65.55.34.15]) by ozlabs.org (Postfix) with ESMTP id 46EB7DE3BA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 08:06:48 +1100 (EST)
Message-ID: <COL107-W44FFF7851D2900D10D2E6FB2330@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_e6639eb0-6b4b-4c44-a234-2aa3e70a3c6e_"
From: MingLiu <eemingliu@hotmail.com>
To: John Linn <john.linn@xilinx.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: xparameters file in the Xilinx kernel tree version 2.6.27-rc4
Date: Thu, 16 Oct 2008 21:06:47 +0000
In-Reply-To: <20081016194824.BBC2B10F8083@mail171-dub.bigfish.com>
References: <COL107-W14F82F8CC72D8E57C374ABB2330@phx.gbl>
	<20081016194824.BBC2B10F8083@mail171-dub.bigfish.com>
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

--_e6639eb0-6b4b-4c44-a234-2aa3e70a3c6e_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear John,
Thanks a lot for your quick answering. I am reading the Wiki now...
 
BR
Ming
 



Subject: RE: xparameters file in the Xilinx kernel tree version 2.6.27-rc4Date: Thu, 16 Oct 2008 13:48:22 -0600From: John.Linn@xilinx.comTo: eemingliu@hotmail.com; linuxppc-embedded@ozlabs.org






Hi Ming,
 
Arch/ppc has gone away.  We don’t support it any longer as it went away in the mainline kernel also.  You should migrate to arch/powerpc.
 
There is a git tag, last-arch-ppc, that is visible from http://git.xilinx.com/linux-2.6-xlnx.git.  You can use that tag in git to reset back to that tag.  Or after clicking on that tag towards the bottom on the http page, you can go to the tree view and get any individual files you would like.
 
You should go to our wiki site, http://xilinx.wikidot.com to get more data on how to build the newer kernel. 
 
Thanks,
John
 





From: linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org [mailto:linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org] On Behalf Of MingLiuSent: Thursday, October 16, 2008 1:39 PMTo: linuxppc-embedded@ozlabs.orgSubject: xparameters file in the Xilinx kernel tree version 2.6.27-rc4
 
Dear all,I downloaded the newest version 2.6.27 kernel from the Xilinx tree. I found that it is much different with the previous version 2.6.24-rc8 we are using. Maybe my question is stupid, but I cannot find the previous xparameters_ml40x.h file in arch/ppc/platform/4xx/xparameters/ in the new arch/powerpc folder. So how can I import my BSP parameters in the new kernel for the customized design? One more question is, I tried "make zImage". But I cannot find the generated zImage.elf, as the previous kernel will do.How to generate the .elf kernel file? Thanks for your help and answering. BRMing 



使用新一代 Windows Live Messenger 轻松交流和共享！ 立即体验！This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately. 
_________________________________________________________________
多个邮箱同步管理，live mail客户端万人抢用中
http://get.live.cn/product/mail.html
--_e6639eb0-6b4b-4c44-a234-2aa3e70a3c6e_
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
Thanks a lot for your quick answering. I am reading the Wiki now...<BR>
&nbsp;<BR>
BR<BR>
Ming<BR>
<BR><BR>&nbsp;<BR>

<HR>
<BR>
Subject: RE: xparameters file in the Xilinx kernel tree version 2.6.27-rc4<BR>Date: Thu, 16 Oct 2008 13:48:22 -0600<BR>From: John.Linn@xilinx.com<BR>To: eemingliu@hotmail.com; linuxppc-embedded@ozlabs.org<BR><BR><BR>
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
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">Arch/ppc has gone away. &nbsp;We don’t support it any longer as it went away in the mainline kernel also. &nbsp;You should migrate to arch/powerpc.</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">There is a git tag, last-arch-ppc, that is visible from <A href="http://git.xilinx.com/linux-2.6-xlnx.git" target=_blank>http://git.xilinx.com/linux-2.6-xlnx.git</A>. &nbsp;You can use that tag in git to reset back to that tag. &nbsp;Or after clicking on that tag towards the bottom on the http page, you can go to the tree view and get any individual files you would like.</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">You should go to our wiki site, <A href="http://xilinx.wikidot.com/" target=_blank>http://xilinx.wikidot.com</A> to get more data on how to build the newer kernel. </SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">Thanks,</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">John</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial color=navy size=2><SPAN style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<DIV style="BORDER-RIGHT: medium none; PADDING-RIGHT: 0in; BORDER-TOP: medium none; PADDING-LEFT: 4pt; PADDING-BOTTOM: 0in; BORDER-LEFT: blue 1.5pt solid; PADDING-TOP: 0in; BORDER-BOTTOM: medium none">
<DIV>
<DIV class=EC_MsoNormal style="TEXT-ALIGN: center" align=center><FONT face=SimSun size=3><SPAN style="FONT-SIZE: 12pt">
<HR align=center width="100%" SIZE=2>
</SPAN></FONT></DIV>
<P class=EC_MsoNormal><B><FONT face=Tahoma size=2><SPAN style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Tahoma">From:</SPAN></FONT></B><FONT face=Tahoma size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Tahoma"> linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org [mailto:linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org] <B><SPAN style="FONT-WEIGHT: bold">On Behalf Of </SPAN></B>MingLiu<BR><B><SPAN style="FONT-WEIGHT: bold">Sent:</SPAN></B> Thursday, October 16, 2008 1:39 PM<BR><B><SPAN style="FONT-WEIGHT: bold">To:</SPAN></B> linuxppc-embedded@ozlabs.org<BR><B><SPAN style="FONT-WEIGHT: bold">Subject:</SPAN></B> xparameters file in the Xilinx kernel tree version 2.6.27-rc4</SPAN></FONT></P></DIV>
<P class=EC_MsoNormal><FONT face=SimSun size=3><SPAN style="FONT-SIZE: 12pt">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal style="MARGIN-BOTTOM: 12pt"><FONT face=Tahoma size=1><SPAN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">Dear all,<BR>I downloaded the newest version 2.6.27 kernel from the Xilinx tree. I found that it is much different with the previous version 2.6.24-rc8 we are using. Maybe my question is stupid, but I cannot find the previous xparameters_ml40x.h file in arch/ppc/platform/4xx/xparameters/ in the new arch/powerpc folder. So how can I import my BSP parameters in the new kernel for the customized design?<BR>&nbsp;<BR>One more question is, I tried "make zImage". But I cannot find the generated zImage.elf,&nbsp;as the previous kernel will do.How to generate the .elf kernel file?<BR>&nbsp;<BR>Thanks for your help and answering.<BR>&nbsp;<BR>BR<BR>Ming<BR>&nbsp;</SPAN></FONT></P>
<DIV class=EC_MsoNormal style="TEXT-ALIGN: center" align=center><FONT face=Tahoma size=1><SPAN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma">
<HR align=center width="100%" SIZE=2>
</SPAN></FONT></DIV>
<P class=EC_MsoNormal><FONT face=SimSun size=1><SPAN lang=ZH-CN style="FONT-SIZE: 9pt">使用新一代</SPAN></FONT><FONT face=Tahoma size=1><SPAN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"> Windows Live Messenger </SPAN></FONT><FONT size=1><SPAN lang=ZH-CN style="FONT-SIZE: 9pt">轻松交流和共享！</SPAN></FONT><FONT face=Tahoma size=1><SPAN lang=ZH-CN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"> </SPAN></FONT><FONT face=Tahoma size=1><SPAN style="FONT-SIZE: 9pt; FONT-FAMILY: Tahoma"><A href="http://messenger.live.cn/" target=_blank><FONT face=SimSun><SPAN lang=ZH-CN style="FONT-FAMILY: SimSun">立即体验！</SPAN></FONT></A></SPAN></FONT></P></DIV></DIV><BR clear=all>This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately. <br /><hr />用 Windows Live Spaces 展示个性自我，与好友分享生活！  <a href='http://spaces.live.com/?page=HP' target='_new'>了解更多信息！</a></body>
</html>
--_e6639eb0-6b4b-4c44-a234-2aa3e70a3c6e_--
