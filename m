Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB403@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: "'Ing.Gianfranco Morandi'" <gianfranco.morandi@euro-studio.it>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: HHL 2.1 preview kit
Date: Thu, 3 Oct 2002 09:20:40 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you need to change some definitions in makefile

ARCH := ppc
CROSS_COMPILE = ppc_82xx-

Bo

-----Original Message-----
From: Ing.Gianfranco Morandi [mailto:gianfranco.morandi@euro-studio.it]
Sent: Thursday, October 03, 2002 9:11 AM
To: LinuxPPC
Subject: HHL 2.1 preview kit



Hi to all,

I have a question regarding the preview kit of Montavista.

I have downloaded the CD Image and installed the tools for the Sandpoint
8240 (which should be an 82xx architecture).

When I try to configure the kernel with "make config" command, no processor
other than x86 can be selected.
In other word I cannot select the Power PC architecture.

I would like to install the kit for the EST8260 board and I thought that
such installation was a good base to start.

Anybody has suggestions to give me?

Any help is appreciated.

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
