Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s26.bay0.hotmail.com (bay0-omc2-s26.bay0.hotmail.com
	[65.54.246.162]) by ozlabs.org (Postfix) with ESMTP id 80477DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 20:43:17 +1100 (EST)
Message-ID: <BAY138-W14E797CEC95B3B3375024DB28B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c672c47b-ab80-4af1-b0e3-d6ad9cdab64b_"
From: MingLiu <eemingliu@hotmail.com>
To: schardt <g.schardt@fz-juelich.de>
Subject: RE: Bootloader & Flash
Date: Thu, 8 Nov 2007 09:43:15 +0000
In-Reply-To: <4732B492.5010604@fz-juelich.de>
References: <4731A8E3.4020909@fz-juelich.de>
	<BAY138-W14EEE9667CD669878D3BD0B28A0@phx.gbl>
	<4732B492.5010604@fz-juelich.de>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_c672c47b-ab80-4af1-b0e3-d6ad9cdab64b_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi,
 > Could I store both, hw bitstream and kernel, in the xilinx platform> flash ? i think its not bit enough. I want to store the hw bitstream in> the platform flash as usual and the kernel in the additional flash.> I don't know how to store the kernel in the flash until know. This why I> try with the MTD devices.
 
You can store HW with EDK bootloader on either of the flashes. But you can only store kernel in linear flash because it is accessible through opb bus. 
> I want the root-fs on flash, but this is future :) First i try to boot> the kernel
I do not have experience to set up a file system in flash memory. What I have done is to put it in the CF card or via NFS. But I guess with MTD driver's support, it will not be difficult to do that. 
 
Good luck.
 
BR
Ming
_________________________________________________________________
手机也能上 MSN 聊天了，快来试试吧！
http://mobile.msn.com.cn/
--_c672c47b-ab80-4af1-b0e3-d6ad9cdab64b_
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
Hi,<BR>
&nbsp;<BR>&gt; Could I store both, hw bitstream and kernel, in the xilinx platform<BR>&gt; flash ? i think its not bit enough. I want to store the hw bitstream in<BR>&gt; the platform flash as usual and the kernel in the additional flash.<BR>&gt; I don't know how to store the kernel in the flash until know. This why I<BR>&gt; try with the MTD devices.<BR>
&nbsp;<BR>
You can store HW with EDK bootloader on either of the flashes. But you can only store kernel in linear flash because it is accessible through opb bus. <BR>
<BR>&gt; I want the root-fs on flash, but this is future :) First i try to boot<BR>&gt; the kernel<BR><BR>
I do not have experience to set up a file system in flash memory. What I have done is to put it in the CF card or via NFS. But I guess with MTD driver's support, it will not be difficult to do that. <BR>
&nbsp;<BR>
Good luck.<BR>
&nbsp;<BR>
BR<BR>
Ming<BR><br /><hr />Windows Live Writer 让您告别龟速网络，轻松写日志！ <a href='http://writer.live.com/' target='_new'>立即使用！</a></body>
</html>
--_c672c47b-ab80-4af1-b0e3-d6ad9cdab64b_--
