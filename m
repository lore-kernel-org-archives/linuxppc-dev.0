Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Brian Padalino" <bpadalino@perigee.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: U-Boot, tftp and PCI ethernet
Date: Fri, 25 Jul 2003 08:10:49 -0400
Message-ID: <DGEEIPOFGGPOACEFBGGCGEJFCAAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does U-Boot support booting over ethernet controllers found on the PCI bus,
specifically I am wondering how hard it would be to boot from an Intel e1000
ethernet controller rather than the on-chip ethernet on my Ebony board.

Has anyone had experience with this, or can point me in the right direction
on where to look to write some simple drivers to support transfers from the
e1000 card, that would be great.

Thanks,
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
