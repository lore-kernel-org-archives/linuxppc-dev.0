Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 29 Jun 2004 09:02:31 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel option "Command line partition table parsing" 
In-Reply-To: <20040629125710.B6B28C109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0406290859430.24373@localhost.localdomain>
References: <20040629125710.B6B28C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 29 Jun 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0406290821150.19485@localhost.localdomain> you wrote:
>>
>>    i'm intrigued by the above kernel option.  currently, i define my
>> MTD partitions in drivers/mtd/maps/rpxlite.c, using structs map_info,
>> mtd_info, etc., and calling the appropriate routines, which works just
>> fine.
>>
>>    will this kernel option actually let me define the basic MTD
>> partitions completely from the kernel command line without messing
>> with rpxlite.c?  or am i misreading the purpose of this option?
>
> Yes, it will.
>
> See http://www.denx.de/twiki/bin/view/DULG/BootTimeConfigurationOfMTDPartitions

excellent, this just gets better and better.  however, will partition
definitions on the command line override those in rpxlite.c?  i notice
that the generic rpxlite.c that comes from the bk tree has a default
partition definition of fe000000/800000.  should that be removed
first?  or will it be ignored?  it's not clear from the comments in
the source.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
