Date: Fri, 19 Nov 1999 15:52:08 -0500
From: Jeremy Katz <katzj@linuxpower.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problems Rebuilding glibc
Message-ID: <19991119155208.I31049@blackhole.ncssm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.  I'm currently working on getting all sorts of kerberos/afs/hesiod
nastiness working under linuxppc.  At present, doing this requires a
patch to glibc for hesiod initgroups support (I actually think that the
patch is in the current cvs tree for glibc, but didn't quite make it
into the glibc-2.1.2 release).  Unfortunately, while trying to rebuild
the rpm with the patches, I get the following internal compiler error --

rtld.c:143: warning: `_dl_start' defined but not used
/usr/src/redhat/BUILD/egcs-1.1.2/gcc/config/rs6000/rs6000.c:2296:
Internal compiler error in function rs6000_got_register
make[2]: ***
[/home/katzj/projects/redhat/BUILD/glibc-2.1/build-ppc-linux/elf/dl-profile.os]
Error 1
make[2]: Leaving directory `/mnt/home/katzj/BUILD/glibc-2.1/elf'
make[1]: *** [elf/subdir_lib] Error 2
make[1]: Leaving directory `/mnt/home/katzj/BUILD/glibc-2.1'
make: *** [all] Error 2
Bad exit status from /var/tmp/rpm-tmp.66411 (%build)

Note that I'm building using the glibc rpm from RedHat 6.1 with the one
necessary patch.  Are there any PPC specific patches which need to be
applied (from looking at the srpm for the normal linuxppc glibc, it
doesn't look like it)

Thanks,

Jeremy

PS Please CC me as I'm only subscribed to linuxppc-dev-digest

--
Jeremy Katz		http://linuxpower.org
Personal: katzj@linuxpower.org
School: jlkatz@unity.ncsu.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
