Date: Thu, 3 Feb 2000 11:10:50 +0100 (MET)
From: "Ingvar Hagelund; UiO" <ingvar@unik.no>
To: linuxppc-workstation@lists.linuxppc.org
cc: linuxppc-dev@lists.linuxppc.org
Subject: /dev/fb0 device does not exist
In-Reply-To: <389927FC.6BE10CF0@amberdata.demon.co.uk>
Message-ID: <Pine.GSO.4.10.10002031027020.7245-100000@tyr.unik.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hello again everybody

I'm back with some questions on linuxppc-1999 on the 43P-133 (7248-133).

When I try to start the fb_dev X-server or try to use the fbset command, I
only get the error
/dev/fb0: No such device

ls -l /dev/fb0 gives me
crw----rwx   1 ingvar   root      29,   0 Jan 28  2000 /dev/fb0

so the device file should exist.

Does this mean my kernel has no support for the frame buffer device?

I run linuxppc-1999 with kernel 2.2.6-16aprep, with no changes on the
kernel since the installation.

Ingvar

------------------------------------------------------------------------
Ingvar Hagelund             Phone: (+47) 22740512
E-mail: ingvar@unik.no      WWW: http://www.ifi.uio.no/~ingvarha
Adress: Ringshusveien 10,   N-1176  OSLO, NORWAY
Experience GNU/Linux!

linuxppc-1999 installation howto for the 7248 @
http://www.ifi.uio.no/~ingvarha/43p
-------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
