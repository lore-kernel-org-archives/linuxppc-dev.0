Return-Path: <zhulida@hotmail.com>
Received: from bay0-omc2-s11.bay0.hotmail.com (bay0-omc2-s11.bay0.hotmail.com
	[65.54.246.147]) by ozlabs.org (Postfix) with ESMTP id 44334DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 May 2008 18:31:33 +1000 (EST)
Message-ID: <BAY124-W49CC670970046CAE18FB33A8B90@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_b57ef365-80b9-45f5-a9b3-fdb5636b579d_"
From: =?gb2312?B?1uzA+7Tv?= <zhulida@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: FW: Error occured when appended FPGA image in the section of
	.init.text then bootup
Date: Sat, 31 May 2008 16:31:31 +0800
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

--_b57ef365-80b9-45f5-a9b3-fdb5636b579d_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi all.   These days , I haved been troubled by a trouble. As I am a new boy who play with linux and PowPc603e(MPC8247). I have no ideal to solve it. 
   The request below give rise to the problem.I have some boards equiped with MPC8247 and FPGA without storage media which used as a PCI interface. So when the linux bootup before initialize the PCI, the code of FPGA will download. I append the FPGA code file in the Kernel section '.init.text'. when linux bootup firstly it check the board type(different board type would download different code), and download fpga code. More board types lead to more FPGA code. I append them all in the section of '.init.text'.  when the total size of the code reach out 2M. The error occured. I read the '__log_buf' the kernel access some bad area. As the powerpce603 will map 16M address use two bat, how and why the problem occured, and how to solved it .
  I kown it can download in the bootloader who read the FPGA image in the flash.But when the the flash is blank and the systerm boot from the tftp using a Muti-file image, another proble will occured.
 
                                    You advice will helpful! Sorry for my poor english! 
_________________________________________________________________
用手机MSN聊天写邮件看空间，无限沟通，分享精彩！
http://mobile.msn.com.cn/
--_b57ef365-80b9-45f5-a9b3-fdb5636b579d_
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
<BLOCKQUOTE><FONT size=4>Hi all.<BR>&nbsp;&nbsp; </FONT><FONT size=4>These days , I haved been troubled by a trouble. As I am a new boy who play with linux and PowPc603e(MPC8247). I have no ideal to solve it.</FONT> 
<P align=left><FONT size=4>&nbsp;&nbsp; </FONT><FONT size=4>The request below give rise to the problem.<BR>I have some boards equiped with MPC8247 and FPGA without storage media which used as a PCI interface. So when the linux bootup before initialize the PCI, the code of FPGA will download. I append the FPGA code file in the Kernel section '.init.text'. when linux bootup firstly it check the board type(different board type would download different code), and download fpga code. More board types lead to more FPGA code. I append them all in the section of '.init.text'.&nbsp; when the total size of the code reach out 2M. The error occured. I read the '__log_buf' the kernel access some bad area. As the powerpce603 will map 16M address use two bat, how and&nbsp;why the problem occured, and how to solved it .</FONT></P>
<P align=left><FONT size=4>&nbsp; </FONT><FONT size=4>I kown it can download in the bootloader who read the FPGA image in the flash.But when the the flash is blank and the systerm boot from the tftp using a Muti-file image, another proble will occured.</FONT></P>
<P align=left><FONT size=4>&nbsp;</FONT></P>
<P align=left><FONT size=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; You advice will helpful! Sorry for my poor english!</FONT></P><FONT size=4>&nbsp;<BR></FONT></BLOCKQUOTE><br /><hr />Windows Live Writer，支持离线撰写博客内容，随时随地想写就写。 <a href='http://get.live.cn/product/writer.html' target='_new'>立即使用！</a></body>
</html>
--_b57ef365-80b9-45f5-a9b3-fdb5636b579d_--
