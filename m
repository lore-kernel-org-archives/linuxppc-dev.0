Message-ID: <20030709050619.19722.qmail@web9705.mail.yahoo.com>
Date: Tue, 8 Jul 2003 22:06:19 -0700 (PDT)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: Problem with starting up 2.4.21 kernel
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F0B9F69.1030801@tait.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 There are mainly two things that you sould check:

1. Have you configured correctly the timers? It
depends
from your configuration, but ppcboot could pass to the
kernel the clocks in Mhz, although kernel could need
it in Hertz.(I dont remember exactly who needs what,
but I hope you understand that the mapping sould
be the same..)(Well, I always had to change that
inside the kernel..??...)

2. Have you correctly configured the serial interface
(where you have your console)? SCC,SMC..etc.

And, could you see inside the System.map in what
function does your kernel locks?

                 Dimitris.

--- Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
wrote:
>
> After "Transferring control to Linux (at address
> 00000000)" nothing seems happen (see below). From
> BDI2000 I discovered that it shorlty after locks at
> 0xc0092aec address (the MPC866ADS eval board used).
> I tried to turn on the kernel hacking options and
> turn off everything I don't need right now but it
> does not help a lot.
> Could anybody give me a clue what this could be
> about.
>
> Thank you in advance for any help.
>
> ### main_loop: bootcmd="bootm 0x2880000 0x2900000;
> setenv bootargs root=/dev/ram rw"
> Hit any key to stop autoboot:  0
> ## Booting image at 02880000 ...
>    Image Name:   Linux-2.4.21-erik
>    Image Type:   PowerPC Linux Kernel Image (gzip
> compressed)
>    Data Size:    489849 Bytes = 478.4 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Current stack ends at 0x0075BBE8 => set upper
> limit to 0x0075B3E0
> ## cmdline at 0x0075B2E0 ... 0x0075B2F0
> bd address  = 0x0075BFC4
> memstart    = 0x00000000
> memsize     = 0x00800000
> flashstart  = 0x02800000
> flashsize   = 0x00200000
> flashoffset = 0x00025000
> sramstart   = 0x00000000
> sramsize    = 0x00000000
> immr_base   = 0x02200000
> bootflags   = 0x00000001
> intfreq     =     50 MHz
> busfreq     =     50 MHz
> ethaddr     = 00:24:20:10:18:6A
> IP addr     = 172.25.193.23
> baudrate    =  19200 bps
> ## Loading RAMDisk Image at 02900000 ...
>    Image Name:   Simple Ramdisk Image
>    Image Type:   PowerPC Linux RAMDisk Image (gzip
> compressed)
>    Data Size:    859578 Bytes = 839.4 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## initrd at 0x02900040 ... 0x029D1DF9
> (len=859578=0xD1DBA)
>    Loading Ramdisk to 00689000, end 0075adba ... OK
> ## Transferring control to Linux (at address
> 00000000) ...
>
>
>


=====
------------------------------------------------------------
-Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
 Greece.
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
