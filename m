Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9E8D@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Alex Zeffertt'" <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ramdisk problems: No init found
Date: Wed, 12 Dec 2001 12:35:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I don't understand why the kernel cannot find /sbin/init - it
> is definitely being built.

The size of the RAM disk image (97kb) suggests that the shared librairies
that busybox needs are missing. Either you include them in the image, or you
link busybox statically.


--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
