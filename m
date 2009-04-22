Return-Path: <nicolas.lavocat@fr.thalesgroup.com>
Received: from thsmsgxrt13p.thalesgroup.com (thsmsgxrt13p.thalesgroup.com
	[192.54.144.136]) by ozlabs.org (Postfix) with ESMTP id 1B278DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 19:10:53 +1000 (EST)
Received: from thsmsgirt26p.corp.thales (unknown [10.33.231.4])
	by thsmsgxrt13p.thalesgroup.com (Postfix) with ESMTP id 71C54360D7E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:10:50 +0200 (CEST)
Received: from thsmsgiav11p.corp.thales (10.33.231.31) by
	thsmsgirt26p.corp.thales (8.5.103)
	id 4991986400746A8C for linuxppc-dev@ozlabs.org;
	Wed, 22 Apr 2009 11:10:50 +0200
Received: from vpsms001.fr.thav.thales (unknown [10.33.12.35])
	by thsmsgirt11p.corp.thales (Postfix) with ESMTP id 48C09598052
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:10:50 +0200 (CEST)
Received: from vpspms02.val.fr.thav.thales (128.1.6.82) by
	vpsms001.fr.thav.thales (NPlex 6.5.026)
	id 49EBDED400025BAE for linuxppc-dev@ozlabs.org;
	Wed, 22 Apr 2009 11:10:50 +0200
Received: from vpspms02.val.fr.thav.thales (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 30FA5807E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:10:50 +0200 (CEST)
Received: from xbdxuspmail.bdx.fr.thav.thales (xbdxuspmail.bdx.fr.thav.thales
	[128.1.62.154])
	by vpspms02.val.fr.thav.thales (Postfix) with ESMTP id E3EBD8091
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 11:10:49 +0200 (CEST)
Message-ID: <49EEDF17.9010109@fr.thalesgroup.com>
Date: Wed, 22 Apr 2009 11:10:47 +0200
From: Nicolas Lavocat <nicolas.lavocat@fr.thalesgroup.com>
MIME-Version: 1.0
To: Liu Dave-R63238 <DaveLiu@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: freeze when reading a PCI bridge register
References: <49EECF8D.9000808@fr.thalesgroup.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208928C4DB@zch01exm21.fsl.freescale.net>
	<49EED5EB.7050005@fr.thalesgroup.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208928C4DD@zch01exm21.fsl.freescale.net>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208928C4DD@zch01exm21.fsl.freescale.net>
Content-Type: text/html; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hum... It is a proprietary bridge... I don't know how works the marvel,
but it is not like tundra (TSI108)... But&nbsp; it seems that this bridge
works like X86 bridges.&nbsp; I 'm goigng to read documentations about
Marvel bridges! <br>
<br>
Nicolas Lavocat <br>
<br>
Liu Dave-R63238 a &eacute;crit&nbsp;:
<blockquote
 cite="midD7CCA83BB0796C49BC0BB53B6AB1208928C4DD@zch01exm21.fsl.freescale.net"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta content="MSHTML 6.00.2900.3492" name="GENERATOR">
  <div dir="ltr" align="left"><span class="549463208-22042009"><font
 color="#0000ff" face="Arial" size="2">So the host bridge is important,
what is the bridge?</font></span></div>
  <div dir="ltr" align="left"><span class="549463208-22042009"><font
 color="#0000ff" face="Arial" size="2">Marvell or Tundra chipset?</font></span></div>
  <div dir="ltr" align="left"><span class="549463208-22042009"></span>&nbsp;</div>
  <br>
  <blockquote dir="ltr"
 style="border-left: 2px solid rgb(0, 0, 255); padding-left: 5px; margin-left: 5px; margin-right: 0px;">
    <div class="OutlookMessageHeader" dir="ltr" align="left"
 lang="en-us">
    <hr tabindex="-1"> <font face="Tahoma" size="2"><b>From:</b>
Nicolas Lavocat [<a class="moz-txt-link-freetext" href="mailto:nicolas.lavocat@fr.thalesgroup.com">mailto:nicolas.lavocat@fr.thalesgroup.com</a>] <br>
    <b>Sent:</b> Wednesday, April 22, 2009 4:32 PM<br>
    <b>To:</b> Liu Dave-R63238<br>
    <b>Cc:</b> linuxppc-dev<br>
    <b>Subject:</b> Re: freeze when reading a PCI bridge register<br>
    </font><br>
    </div>
a 7448<br>
    <br>
Liu Dave-R63238 a &eacute;crit&nbsp;:
    <blockquote
 cite="midD7CCA83BB0796C49BC0BB53B6AB1208928C4DB@zch01exm21.fsl.freescale.net"
 type="cite">
      <blockquote type="cite">
        <pre wrap="">I' am trying to configure a PCI bridge on a private board, with a 
powerpc . In a first time, I tried to get informations about PCI 
devices, in order to be sure  that  my read  and write methods work ( 
using 2 configuration registers, like on an x86 architecture.) . 2 
configuration registers  are used, for example we  write  an encoded 
address (it is a request to a PCI device) in the first and 
the answer of 
the PCI device can be read in the second register (it is a 
configuration 
cycle)
Firstly, I did it by JTAG: it works. Then, under uboot, it is ok.

For example, the code used under u-boot:

volatile u32* addr;
u32 vendor_device_ID;

puts("PCI1 reading PCI VENDOR and DEVICE ID\n");
addr=CFG_ADDR_PCI1;
*addr=0x80007800;

addr= CFG_DATA_PCI1;
vendor_device_ID= *addr;
printf("PCI1: PCI1_VENDOR_DEVICE_ID= %08x  \n" ,vendor_device_ID);


Therefore, when I do the same thing under Linux, the system 
crash when I 
try to read the second register...
Linux is frozen, and there is no error message.
Under Linux, I made an ioremap before use the registers and access to 
these registers thanks to  functions  "in_be32" and "out_be32".
I tried with different endianness to avoid an error of this type.

If I understand, the main difference between u-boot and Linux (about 
registers access) is the activation of the MMU.
So I thought that  problem could come from it. 
I think the problem could came from the configuration of DBAT 
and IBATS 
registers of the MMU, but I didn't found any information 
about the MMU 
configuration under Linux.
So after this novel, I have some questions:

-Is the MMU configuration generic under Linux?
-Does somebody think that the problem doesn't come from MMU?
-How does work ioremap? Is it a fully software function, or does it 
speaks to MMU to get the effective address from physical address?
-Does somebody have an idea, or a documentation about MMU 
configuration 
under linux?
-Do you think that my MMU is under the control of an evil spirit? ^^

    </pre>
      </blockquote>
      <pre wrap=""><!---->What is the PowerPC you are using?

  </pre>
    </blockquote>
  </blockquote>
</blockquote>
</body>
</html>
