Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <CA78D1B723D8D411AF0300508BDCF74F3F6D37@NTCORREO>
From: IGOR LURI <iluri@fagorautomation.es>
To: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: Direct IDE on PCMCIA port
Date: Tue, 23 Jul 2002 16:22:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

We have a custom board based on mpc823 with Linux 2.4.4 from Denx Software
Engineering and we want to initialize the PCMCIA interface as True IDE mode.


 We want to use "MPC8xx Direct IDE support on PCMCIA port" option of the
kernel to acces a Compact Flash or a PC IDE HardDisk. To use this option,
the firmware has to initialize the PCMCIA interface.

I have seen in the PPCBoot source code a function called "ide_init" that
initialize PCMCIA interface as a common memory space . The Compact Flash can
work as a common memory space but a PC IDE HarDisk only supports True IDE
mode.

Someone knows how can we initialize PCMCIA registers to acces a disk
(Compact Flash or IDE HarDisk) in True IDE mode?


Thanks in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
