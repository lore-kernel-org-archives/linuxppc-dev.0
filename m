Message-ID: <XFMail.990113161857.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <19990113104026.C1056@dirkpitt.solsoft.fr>
Date: Wed, 13 Jan 1999 16:18:57 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
Subject: Re: Porting to NuBus PowerMacs
Cc: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 13-Jan-99 Hubert Figuiere wrote:
> 
> According to Benjamin Herrenschmidt <bh40@calva.net>:
> 
>> >-we have the source of the Mach MicroKernel, hence we have enough
>> > to rewrite the specification to rewrite drivers for LinuxPPC.
>> > Some components and drivers may directly come from Linux Mac68k.
>> 
>> We have also a lot of potentially useful things in the mac68k and APUS ports.
>> 
>> >Note that I don't have a NuBus PowerMac. Only a 6200 (and my
>> >PowerCenter Pro, already supported).
>> 
>> ;-)
> 
> I'm investigating the possibilities to support 5200/6200 (and its
> little brother 5300/6300) just because this machine is:
> 
> a) not supported by either MkLinux or LinuxPPC
> b) I have one (in fact my fiancee has it).
> 
> There are several custom chips inside (like on any other Mac).
> First the big problem is that 6200 is a PowerPC inside a 68040
> machine. It uses a "CAPELLA" custom chip as a bus translation
> unit. This may be a problem since I don't think it is used in any
> supported PowerMac.
> 
> RAM: 2 simm slot on a 68040 data bus.
> 
> Video: It is a "Valkyrie" Chip using a DRAM frame buffer. If I
> remember, Valkyrie is available in several PowerMacs and is
> already supported.
> 
> Memory Controller: it is a "F108" as in the LC 630 (ses Linux 68k
> port) that also handles IDE, SCSI and SCC serial ports. SCSI in
> this chip is a NCR 53C96. SCC is like the 8530 SCC (that we find
> in several Macs too).
> 
> ADB: "CUDA" chip similar to several 68k Mac. Accessed thru the
> "PrimeTime II". It is the 68HC05 and also handles PRAM, RTC,
> power supply control.
> 
> Sound: a "DFAC II" chip.
> 
> Other: "PRIMETIME II" chip manages SWIM II, VIA1, VIA2, sound
> controller and I/O bus adpater. Manages ADB sounds, CommSlot, PDS.
> 
> You can find the technote here:
> 
> http://developer.apple.com/techpubs/hardware/hardware2.html
> 

This document does not have enough detail to be able to make a port 
for this hardware.  As far as I know, such details are only available
directly from Apple under NDA until they decide to "leak" the info
out, such as releasing ports, drivers, etc.

> Note that I have no porting experience. :-)

We all start somewhere :-)


------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
