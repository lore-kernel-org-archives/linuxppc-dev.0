Message-ID: <E8F83D6D2A6AD3118E0300902786A2050237142D@NTEX>
From: "David Marqvar (DAM)" <DAM@tt.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Transfer files via terminal (Zmodem)
Date: Thu, 14 Mar 2002 14:09:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Has anyone compiled sz/rz for ppc (MPC823) in order to use ZModem to
> > transfer files via terminal connection to the target?
> > Or, is the some other way of transferring files to my embedded system.
> > I'm connected to it using a terminal (minicom, kermit). No network.
> ppcboot supports kermit.
> most of us just use srecords over a plain ascii connection.

I want to do it directly within Linux after boot.
(I'm currently running Busybox).
I'm looking for a small Linux-util to reviece files from the serial line.

In a perfect world I would be running "rz > /dev/mtd/3" to download
a new filesystem to my flash. On my host I would send the (raw)
filesystem from minicom... or if I had a kermit "client" for my
ppc-target I would send using kermit.

Thanks anyway :-)

Regards,
David

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
