Message-Id: <4.2.2.19991119221740.04388ce0@mail.munich.netsurf.de>
Date: Fri, 19 Nov 1999 22:25:35 +0100
To: Jeremy Katz <katzj@linuxpower.org>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Problems Rebuilding glibc
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19991119155208.I31049@blackhole.ncssm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 21:52 19.11.99 , Jeremy Katz wrote:

>Hi.  I'm currently working on getting all sorts of kerberos/afs/hesiod
>nastiness working under linuxppc.  At present, doing this requires a
>patch to glibc for hesiod initgroups support (I actually think that the
>patch is in the current cvs tree for glibc, but didn't quite make it
>into the glibc-2.1.2 release).  Unfortunately, while trying to rebuild
>the rpm with the patches, I get the following internal compiler error --
>
>rtld.c:143: warning: `_dl_start' defined but not used
>/usr/src/redhat/BUILD/egcs-1.1.2/gcc/config/rs6000/rs6000.c:2296:

1. your compiler is too old
2. additionally it misses important patches it seems

go to <ftp://devel.linuxppc.org/users/fsirl/R5/> and grab gcc-2.95.2-1c and 
binutils-2.9.5.0.14. Maybe it was already copied to the official R5 updates 
section in the meantime.

FYI, AFAI can see, nothing releated to hesiod initgroups support has been 
checked in for the pending glibc-2.1.3 release.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
