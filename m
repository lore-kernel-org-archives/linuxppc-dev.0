Return-Path: <urwithsudheer@gmail.com>
Received: from predator.gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 65D4F67BAE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jul 2006 18:43:01 +1000 (EST)
Received: from predator.gdatech.co.in (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 6BD311242DD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jul 2006 14:12:24 +0530 (IST)
Received: from predator.gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Propel SE relay 1.0.0.3430
	$Rev$) id r67d141223-00-2
	for linuxppc-embedded@ozlabs.org; Thu, 13 Jul 2006 14:12:24 +0530
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id A81D51242DA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jul 2006 14:12:23 +0530 (IST)
Message-ID: <44B6077E.9090004@gmail.com>
Date: Thu, 13 Jul 2006 14:12:38 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, ilugc@ae.iitm.ac.in
Subject: help regarding powerpc and vga card
Content-Type: multipart/alternative;
	boundary="------------000301030906040900090706"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000301030906040900090706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello All

I am working on a  powerpc board. I have placed the board on a PCI 
backplane and connected a PCI VGA card to the same. PCI enumuration from 
u-boot does not detect my VGA card whereas it detects other cards like 
ethernet in the same slot.

The VGA card details are as follows.

Vendor ID=0x1002 Device ID= 0x4752
Name: ATI Technologies Inc Rage XL

The VGA card is universal compatible. It is working with X86 PC.

In my target system , I have tested adding the vendor id and and device 
id in the u-boot/include/pci_ids.h and declared   the pci_device_id 
structure
in  a new  header file. uboot/include/vga_ragexl.h   . Even then card is 
not getting detected.

Anyone please help me if i am missing anything.

Thanks & Regards
Sudheer.A

--------------000301030906040900090706
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hello All<br>
<br>
<font face="Arial, Helvetica, sans-serif" size="2">I am working on a&nbsp;
powerpc board. I have placed the board on a PCI backplane and
connected a PCI VGA card to the same. PCI enumuration from u-boot does
not detect my VGA card whereas it detects other cards like ethernet in
the same slot.
<br>
<br>
The VGA card details are as follows.
<br>
<br>
Vendor ID=0x1002 Device ID= 0x4752
<br>
Name: ATI Technologies Inc Rage XL
<br>
<br>
The VGA card is universal compatible. It is working with X86 PC.<br>
<br>
In my target system , I have tested adding the vendor id and and device
id in the u-boot/include/pci_ids.h and declared&nbsp;&nbsp; the pci_device_id
structure<br>
in&nbsp; a new&nbsp; header file. uboot/include/vga_ragexl.h &nbsp; . Even then card
is not getting detected. <br>
<br>
</font><font face="Arial, Helvetica, sans-serif" size="2">Anyone please
help me if i am missing anything.<br>
<br>
Thanks &amp; Regards<br>
Sudheer.A<br>
</font>
</body>
</html>

--------------000301030906040900090706--
