Return-Path: <alexeydk78@gmail.com>
Received: from mail-la0-x22e.google.com (mail-la0-x22e.google.com
 [IPv6:2a00:1450:4010:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8FD1D2C0342
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 01:48:00 +1100 (EST)
Received: by mail-la0-f46.google.com with SMTP id eh20so5679994lab.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 07:47:54 -0700 (PDT)
Message-ID: <525C0416.9050303@gmail.com>
Date: Mon, 14 Oct 2013 18:47:50 +0400
From: Alexey Karpov <alexeydk78@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: How to setup linux to the vxworks system?
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

I have a xerox print controller (an "serial number HFT"), used in xerox 
8825, 8830 and 510 wide format print systems, and  wish to use it as a 
little home server. It based on powerpc G4 (MPC7410) and equipped with 2 
PCI slots, 2 DIMM slots, intel-based integrated network card and 2 
firewire ports. There is no video adapter, communication is done via 
RS-232 port.

The problem is installed OS - vxworks and vxworks bootloader. I try to 
load linux kernel with this bootloader, but kernel crashed. Next i try 
to load yaboot (i get it from debian), yaboot seems to be running, but 
trying to write her output to nonexistent videocard. I was try to google 
about how to compile yaboot with uart support, but can't find anything.

Can you help me with booting linux kernel with vxworks bootloader, or 
reflashing this strange device to openfirmware, u-boot, or other 
bootloader to boot linux.
