Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 29 Jun 2004 08:24:51 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel option "Command line partition table parsing"
Message-ID: <Pine.LNX.4.60.0406290821150.19485@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   i'm intrigued by the above kernel option.  currently, i define my
MTD partitions in drivers/mtd/maps/rpxlite.c, using structs map_info,
mtd_info, etc., and calling the appropriate routines, which works just
fine.

   will this kernel option actually let me define the basic MTD
partitions completely from the kernel command line without messing
with rpxlite.c?  or am i misreading the purpose of this option?

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
