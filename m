Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC5200LITE - kernel BUG at page_alloc.c 
Date: Thu, 27 Nov 2003 12:46:35 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED447044@ratatosk.combitechsystems.com>
From: "Tord Andersson" <Tord.Andersson@combitechsystems.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,

Thanks for your reply!
The board is MPC5200Lite EVB version 2 with 16 Mbytes of flash memory.
The PCM is marked rev. G. I will run a memory test as soon as I get
access to the card again.
Below is the U-Boot printout.
...
U-Boot 1.0.1 (Nov 10 2003 - 10:38:02)

CPU:   MPC5200 (JTAG ID 0001101d) at 399.999 MHz
       Bus 133 MHz, IPB 66 MHz, PCI 33 MHz
Board: Motorola MPC5200 (IceCube)
I2C:   86 kHz, ready
DRAM:  64 MB
FLASH: 16 MB
PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5803  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET

Kind regards,

Tord


> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: den 27 november 2003 10:54
> To: Tord Andersson
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: MPC5200LITE - kernel BUG at page_alloc.c
>
>
> Dear Tord,
>
> in message
> <004B1D7A5257174C9044A1B7BD0E60ED447042@ratatosk.combitechsyst
> ems.com> you wrote:
> >
> > I have some troubles when trying to run Linux-2.4.23-pre5 on a an
> > MPC5200LITE board (16MB) with U-BOOT 1.0.1). Right after
> the bogoMIPS
> > calculation I get "kernel BUG at page_alloc.c:105", and the system
> > reboots (see excerpt at end of mail).
>
> Which board revision / configuration is this? Do  you  have
> any  PCI cards  plugged  in?  Dose the simple memory test
> ("mtest" command) in U-Boot work?
>
> > I think the part which goes wrong is when the system tries
> to check if
> > the free pages in memory are OK (__freepages_ok(...)), where the
> > (page->mapping) seems to be marked and thus causing a bug.
> > Is there some kind of problems related to that all pages resides in
> > the zone(0), which seems to be used for DMA?
>
> To me this looks like a memory problem.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email:
> wd@denx.de Making files is easy under  the  UNIX  operating
> system.  Therefore, users  tend  to  create  numerous  files
> using large amounts of file space. It has been said that the
> only standard thing about  all  UNIX systems  is  the
> message-of-the-day  telling users to clean up their
> files.                            -- System V.2 administrator's guide
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
