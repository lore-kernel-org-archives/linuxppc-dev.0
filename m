To: IGOR LURI <iluri@fagorautomation.es>
Cc: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Direct IDE on PCMCIA port 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Jul 2002 16:22:24 +0200."
             <CA78D1B723D8D411AF0300508BDCF74F3F6D37@NTCORREO>
Date: Tue, 23 Jul 2002 17:20:56 +0200
Message-Id: <20020723152101.6930210875@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Igor,

in message <CA78D1B723D8D411AF0300508BDCF74F3F6D37@NTCORREO> you wrote:
>
> We have a custom board based on mpc823 with Linux 2.4.4 from Denx Software
> Engineering and we want to initialize the PCMCIA interface as True IDE mode.

Forget about this terminology. It's only marketing.  Driverwise,  the
PCMCIA  interface  of the typical PCCard Adapters for CF medial looks
like an IDE controller anyway.

>  We want to use "MPC8xx Direct IDE support on PCMCIA port" option of the

Are you sure? Probably you  what  you  really  want  to  use  is  the
8xx_PCCARD option - this is what we use on most boards with CF.

> kernel to acces a Compact Flash or a PC IDE HardDisk. To use this option,
> the firmware has to initialize the PCMCIA interface.

PPCboot does this fine on a couple of boards.

> I have seen in the PPCBoot source code a function called "ide_init" that
> initialize PCMCIA interface as a common memory space . The Compact Flash can
> work as a common memory space but a PC IDE HarDisk only supports True IDE
> mode.

No. The Code as present in PPCBoot works with real IDE  devices  (ATA
or ATAPI interfaces) and with CF etc.

> Someone knows how can we initialize PCMCIA registers to acces a disk
> (Compact Flash or IDE HarDisk) in True IDE mode?

What's wrong with the PPCBoot way? It works...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God made the integers; all else is the work of Man.       - Kronecker

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
