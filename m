Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Tue, 17 Jun 2003 09:26:53 -0500 (CDT)
From: vinai <4_usenet@yahoo.com>
To: "LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
Cc: Debian PowerPC List <debian-powerpc@lists.debian.org>
Subject: firewire issues with 2.4.21 from kernel.org ?
Message-ID: <Pine.LNX.4.44.0306170920360.245-100000@kaiso.biophysics.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey Folks,

Has anyone successfully used the latest kernel.org stable kernel with
firewire successfully ??  I use an external hard drive to be able to
take work with me, but with a 2.4.21 kernel, I get the message:

/dev/sdc2 is not a valid block device

While with 2.4.20 (also from kernel.org), it works perfectly.  This is
on an 8500 using a PCI firewire card with a TI chipset, and running
stock Debian 3.0, except for the kernel upgrade.

cheers
vinai

(to get my real e-mail address, replace "4" with "for")


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
