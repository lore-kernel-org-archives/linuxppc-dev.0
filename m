Date: Thu, 23 Mar 2000 13:11:38 +0100 (MET)
From: "Ingvar Hagelund; UiO" <ingvar@unik.no>
To: Jeff Carr <jcarr@mail.linuxppc.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: LinuxPPC-2000: Bug in the RH installer
In-Reply-To: <Pine.LNX.4.10.10001211706220.29354-100000@mail.linuxppc.org>
Message-ID: <Pine.GSO.4.10.10003231305220.9897-100000@odin.unik.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The CD-ROM images spread to the LinuxPPC mirrors over the world are in hfs
format. The Red Hat installer tries to mount the CD-ROM as an 9660 image.
This won't of course work, and causes problems, for example for RS/6000
owners like myself.

A simple solution would be to change the RH installer so that it mounts
with "-t auto" instead of "-t iso9660". Then it will detect the CD-ROM
properly, both for iso9660 and hfs CD-ROMs.

Regards
Ingvar

------------------------------------------------------------------------
Ingvar Hagelund             Phone: (+47) 22740512
E-mail: ingvar@unik.no      WWW: http://www.ifi.uio.no/~ingvarha
Adress: Ringshusveien 10,   N-1176  OSLO, NORWAY
Experience GNU/Linux!
-------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
