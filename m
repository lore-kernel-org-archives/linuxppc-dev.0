MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problems of kernel-2.6.4 for mpc8260
Date: Wed, 7 Apr 2004 10:56:00 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAB3@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The other version is known not to work with the new module
> initialization stuff in the 2.6 kernels.

Oh, and... You will have to recompile the modules using the recommended
way for 2.6
(eg 'make -C /path/to/linux/ SUBDIRS=$PWD modules') and use the .ko
object files.

There are also some other changes in the module layout.
(see http://lwn.net/Articles/driver-porting/ for more info )

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
