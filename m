Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40E164A6.8060502@246tNt.com>
Date: Tue, 29 Jun 2004 14:46:30 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel option "Command line partition table parsing"
References: <Pine.LNX.4.60.0406290821150.19485@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.60.0406290821150.19485@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Robert P. J. Day wrote:

 >
 > i'm intrigued by the above kernel option.  currently, i define my
 > MTD partitions in drivers/mtd/maps/rpxlite.c, using structs
 > map_info, mtd_info, etc., and calling the appropriate routines,
 > which works just fine.
 >
 > will this kernel option actually let me define the basic MTD
 > partitions completely from the kernel command line without messing
 > with rpxlite.c?  or am i misreading the purpose of this option?

I'd suggest having a look at the comment on top of

drivers/mtd/cmdlinepart.c

But I'm not sure if rpxlite.c . From what I see, it may require to add
a "probe" to look at the command line. Someone ?


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
