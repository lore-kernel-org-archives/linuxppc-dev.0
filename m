Message-ID: <A109131318C4D1119AC20060088DECE330F451@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: "interface.etd1" <interface.etd1@wanadOO.fr>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: Compile gdbserver for powerpc
Date: Tue, 20 Jun 2000 10:35:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>From Graham Stoney's "Linux for PowerPC Embedded Systems HOWTO/FAQ", Section
18.2:

18.2 GDB
Once the kernel is running, you can use gdb in several ways:

native
If you have lots of RAM, you can run it directly on your target. If you are
cross developing, you need to configure gdb with:
% configure --host=powerpc-linux

gdbserver
You can run gdbserver on your target and run gdb back on your development
machine, even if you're cross developing. This requires far less resources
than running all of gdb on your target. See the thread at :
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200001/msg00156.html.
(I did not see anything here about GDB--les)

Get gdbserver, and see the enclosed README at:
ftp://ftp.ppc.kernel.org/pub/linuxppc/embedded/gdbserver.tgz (I could not
connect to this--les)
If you're cross-developing, remember to configure your gdb as described
earlier.

.
.
.
18.3 Kernel
It is not currently possible to use gdb for kenel debugging.
.
.
.
Hope this points you in the right direction.

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.



-----Original Message-----
From: interface.etd1 [mailto:interface.etd1@wanadOO.fr]
Sent: Tuesday, June 20, 2000 10:00 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Compile gdbserver for powerpc



Hi,

I want to debug on an embedded powerpc board from my intel pc.

I don't know if I must use gdbserver or simply gdb on target to debug via
DDD.
I have no ppcbug on my board.

How can I compile gdb with host and target set to powerpc on my intel board
?

When I want to compile gdbserser 4.18 on my pc, gdbserver directory is not
created and no executable is generated !!!

Thanks for your help.

G. Guével

INTERFACE CONCEPT
ZI N°2 des Pays Bas 29510 Briec de l'Odet
FRANCE
(33)02.98.57.30.30
interface.etd1@wanadoo.fr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
