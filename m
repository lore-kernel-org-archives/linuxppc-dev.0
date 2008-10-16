Return-Path: <eemingliu@hotmail.com>
Received: from col0-omc1-s4.col0.hotmail.com (col0-omc1-s4.col0.hotmail.com
	[65.55.34.14]) by ozlabs.org (Postfix) with ESMTP id 0CD19DDF84
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 06:38:47 +1100 (EST)
Message-ID: <COL107-W14F82F8CC72D8E57C374ABB2330@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_dff7b032-e938-41fb-984d-dcae65a7003f_"
From: MingLiu <eemingliu@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: xparameters file in the Xilinx kernel tree version 2.6.27-rc4
Date: Thu, 16 Oct 2008 19:38:46 +0000
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

--_dff7b032-e938-41fb-984d-dcae65a7003f_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Dear all,
I downloaded the newest version 2.6.27 kernel from the Xilinx tree. I found that it is much different with the previous version 2.6.24-rc8 we are using. Maybe my question is stupid, but I cannot find the previous xparameters_ml40x.h file in arch/ppc/platform/4xx/xparameters/ in the new arch/powerpc folder. So how can I import my BSP parameters in the new kernel for the customized design?
 
One more question is, I tried "make zImage". But I cannot find the generated zImage.elf, as the previous kernel will do.How to generate the .elf kernel file?
 
Thanks for your help and answering.
 
BR
Ming
 
_________________________________________________________________
Windows Live Photo gallery 数码相机的超级伴侣，轻松管理和编辑照片，还能制作全景美图！
http://get.live.cn/product/photo.html
--_dff7b032-e938-41fb-984d-dcae65a7003f_
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
I downloaded the newest version 2.6.27 kernel from the Xilinx tree. I found that it is much different with the previous version 2.6.24-rc8 we are using. Maybe my question is stupid, but I cannot find the previous xparameters_ml40x.h file in arch/ppc/platform/4xx/xparameters/ in the new arch/powerpc folder. So how can I import my BSP parameters in the new kernel for the customized design?<BR>
&nbsp;<BR>
One more question is, I tried "make zImage". But I cannot find the generated zImage.elf,&nbsp;as the previous kernel will do.How to generate the .elf kernel file?<BR>
&nbsp;<BR>
Thanks for your help and answering.<BR>
&nbsp;<BR>
BR<BR>
Ming<BR>
&nbsp;<BR><br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://messenger.live.cn/' target='_new'>立即体验！</a></body>
</html>
--_dff7b032-e938-41fb-984d-dcae65a7003f_--
