Date: Thu, 4 Apr 2002 23:42:42 +0100
Subject: Re: SCSI system freeze w/2.4.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: Linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
To: Albrecht Dre? <albrecht.dress@arcor.de>
From: Andrew Bradley <andrew-bradley@ntlworld.com>
In-Reply-To: <20020404195209.GG30247@regulus>
Message-Id: <461A80A2-481D-11D6-8E25-0030654F879C@ntlworld.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Albercht,

I have an 8500 with both mesh and a adaptec 2930 card.
I have a yahmaha cd writer on the mesh interface and a 30gig ultra scsi
2 drive on the adaptec 2930.
I rebuilt 2.4.18 several times with the adaptec card as part of the
kernel as well as the mesh drive.
I have no problems.
I have never used dd for reading files but I have loaded addition rpms
from the stock 7.3 cd disks recently.

I know this does not immediately help but if you want me to try out one
of your scripts with an unmounted cd I will be more than glad to!

Regards
Andrew


On Thursday, April 4, 2002, at 08:52  pm, Albrecht Dre? wrote:

>
> [I already posted this to the users list, but apparently nobody had a
> solution...]
>
> I upgraded my PowerMac 7300 from 2.4.6-pre3 to (stock) 2.4.18, and since
> then I have a nasty scsi problem: Trying to read data from the cd drive
> without a cd loaded (e.g. "dd if=/dev/scd0 of=/dev/null bs=1 count=1")
> freezes the machine. I usually use this command in a shutdown script to
> detect and eventually eject a floppy and a cd. This worked perfectly
> before,
> but hangs without *any* notice in the logs in 2.4.18.
>
> I am almost sure that this is a SCSI problem, as the same script works
> still
> nicely on an iMac (which has a ide cd drive) with 2.4.18.
>
> System details are--
> 	PowerMac 7300/166, CD attached to internal scsi bus (MESH),
> 	verbose scsi logging enabled, mesh compiled into the kernel,
> 	LinuxPPC 2000, upgraded to Halloween release,
> 	kernel 2.4.18 from kernel.org, plus post-release elf patch,
> 	built with gcc-2.95.2, glibc 2.1.3
>
> Thanks in advance for any help,
>
> 	Albrecht.
>
>
> --
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Albrecht Dreß  -  Johanna-Kirchner-Straße 13  -  D-53123 Bonn (Germany)
>        Phone (+49) 228 6199571  -  mailto:albrecht.dress@arcor.de
> _________________________________________________________________________
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
