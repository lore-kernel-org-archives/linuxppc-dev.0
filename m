Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4D414C66@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Michael Habermann'" <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Reducing glibc with mklibs.sh
Date: Wed, 24 Oct 2001 10:16:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> How have you done the libthread? Standard compilation for
> glibc produces
> _pic only for libc on my system. My libm is still quite large.

If the linuxthreads add-on is enabled in your glibc configuration, that
should produce pic & map files, in the following manner:
  ./linuxthreads/libpthread_pic.a
  ./libpthread.map

For libm, it is created in the same way:
  ./math/libm_pic.a
  ./libm.map

And it seems to work very weel for libm too.
No additional object files seems to be necessary, as for libc.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
