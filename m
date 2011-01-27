Return-Path: <g_pr21@yahoo.in>
Received: from nm2.bullet.mail.in.yahoo.com (nm2.bullet.mail.in.yahoo.com
	[121.101.151.224]) by ozlabs.org (Postfix) with SMTP id 7589C1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 16:29:17 +1100 (EST)
Message-ID: <484187.87276.qm@web95709.mail.in.yahoo.com>
Date: Thu, 27 Jan 2011 10:58:14 +0530 (IST)
From: Giriprasad Deviprasad <g_pr21@yahoo.in>
Subject: Buxybox for powerpc not compiling
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1800096128-1296106094=:87276"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-1800096128-1296106094=:87276
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,

=A0I am trying to compile busybox-1.17.1 for mpc8250 based powerpc architec=
ture. My settings are as :

export LDFLAGS=3D"-nostdlib -L/opt/mpc8250/tools/ppc_6xx/usr/lib/"
export LIBRARY_PATH=3D/opt/mpc8250/tools/ppc_6xx/usr/lib/

echo $PATH
/usr/lib/qt-3.3/bin:/usr/kerberos/sbin:/usr/kerberos/bin:/usr/lib/ccache:/o=
pt/mpc8250/tools/usr/bin/:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/u=
sr/bin:/bin:/root/bin

=A0I specified in menuconfig:
CFLAGS as -I/opt/mpc8250/tools/ppc_6xx/usr/include/ -L/opt/mpc8250/tools/pp=
c_6xx/usr/lib/

make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux- --include-dir=3D/opt/mpc=
8250/tools/ppc_6xx/usr/include/ PREFIX=3D/home/user/target/mpc8250/rootfs
=A0 LD=A0=A0=A0=A0=A0 applets/built-in.o
=A0 LINK=A0=A0=A0 busybox_unstripped
Trying libraries: crypt m
Failed: -Wl,--start-group -lcrypt -lm -Wl,--end-group
Output of:
powerpc-linux-gcc -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototype=
s -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-pr=
ototypes -Wmissing-declarations -Wdeclaration-after-statement -Wold-style-d=
efinition -fno-builtin-strlen -finline-limit=3D0 -fomit-frame-pointer -ffun=
ction-sections -fdata-sections -fno-guess-branch-probability -funsigned-cha=
r -static-libgcc -falign-functions=3D1 -falign-jumps=3D1 -falign-labels=3D1=
 -falign-loops=3D1 -Os -I/opt/mpc8250/tools/ppc_6xx/usr/include/ -L/opt/mpc=
8250/tools/ppc_6xx/usr/lib/ -static -nostdlib -L/opt/mpc8250/tools/ppc_6xx/=
usr/lib/ -o busybox_unstripped -Wl,--start-group applets/built-in.o archiva=
l/lib.a archival/libunarchive/lib.a console-tools/lib.a coreutils/lib.a cor=
eutils/libcoreutils/lib.a debianutils/lib.a e2fsprogs/lib.a editors/lib.a f=
indutils/lib.a init/lib.a libbb/lib.a libpwdgrp/lib.a loginutils/lib.a mail=
utils/lib.a miscutils/lib.a modutils/lib.a networking/lib.a
 networking/libiproute/lib.a networking/udhcp/lib.a printutils/lib.a procps=
/lib.a runit/lib.a selinux/lib.a shell/lib.a sysklogd/lib.a util-linux/lib.=
a util-linux/volume_id/lib.a archival/built-in.o archival/libunarchive/buil=
t-in.o console-tools/built-in.o coreutils/built-in.o coreutils/libcoreutils=
/built-in.o debianutils/built-in.o e2fsprogs/built-in.o editors/built-in.o =
findutils/built-in.o init/built-in.o libbb/built-in.o libpwdgrp/built-in.o =
loginutils/built-in.o mailutils/built-in.o miscutils/built-in.o modutils/bu=
ilt-in.o networking/built-in.o networking/libiproute/built-in.o networking/=
udhcp/built-in.o printutils/built-in.o procps/built-in.o runit/built-in.o s=
elinux/built-in.o shell/built-in.o sysklogd/built-in.o util-linux/built-in.=
o util-linux/volume_id/built-in.o -Wl,--end-group -Wl,--start-group -lcrypt=
 -lm -Wl,--end-group
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/opt/mpc8250/tools/usr/bin/../lib/gcc/powerpc-linux/4.2.2/../../../../power=
pc-linux/bin/ld: cannot find -lcrypt
collect2: ld returned 1 exit status
make: *** [busybox_unstripped] Error 1



Also tried:
make ARCH=3Dpowerpc CROSS=3Dpowerpc-linux- --include-dir=3D/opt/mpc8250/too=
ls/ppc_6xx/usr/include/ PREFIX=3D/home/user/target/mpc8250/rootfs
=A0 LINK=A0=A0=A0 busybox_unstripped
Trying libraries: crypt m
Failed: -Wl,--start-group -lcrypt -lm -Wl,--end-group
Output of:
powerpc-linux-gcc -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototype=
s -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-pr=
ototypes -Wmissing-declarations -Wdeclaration-after-statement -Wold-style-d=
efinition -fno-builtin-strlen -finline-limit=3D0 -fomit-frame-pointer -ffun=
ction-sections -fdata-sections -fno-guess-branch-probability -funsigned-cha=
r -static-libgcc -falign-functions=3D1 -falign-jumps=3D1 -falign-labels=3D1=
 -falign-loops=3D1 -Os -I/opt/mpc8250/tools/ppc_6xx/usr/include/ -L/opt/mpc=
8250/tools/ppc_6xx/usr/lib/ -static -nostdlib -L/opt/mpc8250/tools/ppc_6xx/=
usr/lib/ -o busybox_unstripped -Wl,--start-group applets/built-in.o archiva=
l/lib.a archival/libunarchive/lib.a console-tools/lib.a coreutils/lib.a cor=
eutils/libcoreutils/lib.a debianutils/lib.a e2fsprogs/lib.a editors/lib.a f=
indutils/lib.a init/lib.a libbb/lib.a libpwdgrp/lib.a loginutils/lib.a mail=
utils/lib.a miscutils/lib.a modutils/lib.a networking/lib.a
 networking/libiproute/lib.a networking/udhcp/lib.a printutils/lib.a procps=
/lib.a runit/lib.a selinux/lib.a shell/lib.a sysklogd/lib.a util-linux/lib.=
a util-linux/volume_id/lib.a archival/built-in.o archival/libunarchive/buil=
t-in.o console-tools/built-in.o coreutils/built-in.o coreutils/libcoreutils=
/built-in.o debianutils/built-in.o e2fsprogs/built-in.o editors/built-in.o =
findutils/built-in.o init/built-in.o libbb/built-in.o libpwdgrp/built-in.o =
loginutils/built-in.o mailutils/built-in.o miscutils/built-in.o modutils/bu=
ilt-in.o networking/built-in.o networking/libiproute/built-in.o networking/=
udhcp/built-in.o printutils/built-in.o procps/built-in.o runit/built-in.o s=
elinux/built-in.o shell/built-in.o sysklogd/built-in.o util-linux/built-in.=
o util-linux/volume_id/built-in.o -Wl,--end-group -Wl,--start-group -lcrypt=
 -lm -Wl,--end-group
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/opt/mpc8250/tools/usr/bin/../lib/gcc/powerpc-linux/4.2.2/../../../../power=
pc-linux/bin/ld: cannot find -lcrypt
collect2: ld returned 1 exit status
make: *** [busybox_unstripped] Error 1


Any clues as to why this happens?

Thanks & Regards,
D.Giriprasad

=0A=0A
--0-1800096128-1296106094=:87276
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi All,<br><br>&nbsp;I am trying to compile b=
usybox-1.17.1 for mpc8250 based powerpc architecture. My settings are as :<=
br><br>export LDFLAGS=3D"-nostdlib -L/opt/mpc8250/tools/ppc_6xx/usr/lib/"<b=
r>export LIBRARY_PATH=3D/opt/mpc8250/tools/ppc_6xx/usr/lib/<br><br>echo $PA=
TH<br>/usr/lib/qt-3.3/bin:/usr/kerberos/sbin:/usr/kerberos/bin:/usr/lib/cca=
che:/opt/mpc8250/tools/usr/bin/:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/=
bin:/usr/bin:/bin:/root/bin<br><br>&nbsp;I specified in menuconfig:<br>CFLA=
GS as -I/opt/mpc8250/tools/ppc_6xx/usr/include/ -L/opt/mpc8250/tools/ppc_6x=
x/usr/lib/<br><br>make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux- --incl=
ude-dir=3D/opt/mpc8250/tools/ppc_6xx/usr/include/ PREFIX=3D/home/user/targe=
t/mpc8250/rootfs<br>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; applets/built-i=
n.o<br>&nbsp; LINK&nbsp;&nbsp;&nbsp; busybox_unstripped<br>Trying libraries=
: crypt
 m<br>Failed: -Wl,--start-group -lcrypt -lm -Wl,--end-group<br>Output of:<b=
r>powerpc-linux-gcc -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototy=
pes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-=
prototypes -Wmissing-declarations -Wdeclaration-after-statement -Wold-style=
-definition -fno-builtin-strlen -finline-limit=3D0 -fomit-frame-pointer -ff=
unction-sections -fdata-sections -fno-guess-branch-probability -funsigned-c=
har -static-libgcc -falign-functions=3D1 -falign-jumps=3D1 -falign-labels=
=3D1 -falign-loops=3D1 -Os -I/opt/mpc8250/tools/ppc_6xx/usr/include/ -L/opt=
/mpc8250/tools/ppc_6xx/usr/lib/ -static -nostdlib -L/opt/mpc8250/tools/ppc_=
6xx/usr/lib/ -o busybox_unstripped -Wl,--start-group applets/built-in.o arc=
hival/lib.a archival/libunarchive/lib.a console-tools/lib.a coreutils/lib.a=
 coreutils/libcoreutils/lib.a debianutils/lib.a e2fsprogs/lib.a editors/lib=
.a findutils/lib.a init/lib.a libbb/lib.a libpwdgrp/lib.a loginutils/lib.a
 mailutils/lib.a miscutils/lib.a modutils/lib.a networking/lib.a networking=
/libiproute/lib.a networking/udhcp/lib.a printutils/lib.a procps/lib.a runi=
t/lib.a selinux/lib.a shell/lib.a sysklogd/lib.a util-linux/lib.a util-linu=
x/volume_id/lib.a archival/built-in.o archival/libunarchive/built-in.o cons=
ole-tools/built-in.o coreutils/built-in.o coreutils/libcoreutils/built-in.o=
 debianutils/built-in.o e2fsprogs/built-in.o editors/built-in.o findutils/b=
uilt-in.o init/built-in.o libbb/built-in.o libpwdgrp/built-in.o loginutils/=
built-in.o mailutils/built-in.o miscutils/built-in.o modutils/built-in.o ne=
tworking/built-in.o networking/libiproute/built-in.o networking/udhcp/built=
-in.o printutils/built-in.o procps/built-in.o runit/built-in.o selinux/buil=
t-in.o shell/built-in.o sysklogd/built-in.o util-linux/built-in.o util-linu=
x/volume_id/built-in.o -Wl,--end-group -Wl,--start-group -lcrypt -lm
 -Wl,--end-group<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>/opt/mpc8250/tools/us=
r/bin/../lib/gcc/powerpc-linux/4.2.2/../../../../powerpc-linux/bin/ld: cann=
ot find -lcrypt<br>collect2: ld returned 1 exit status<br>make: *** [busybo=
x_unstripped] Error 1<br><br><br><br>Also tried:<br>make ARCH=3Dpowerpc CRO=
SS=3Dpowerpc-linux- --include-dir=3D/opt/mpc8250/tools/ppc_6xx/usr/include/=
 PREFIX=3D/home/user/target/mpc8250/rootfs<br>&nbsp; LINK&nbsp;&nbsp;&nbsp;=
 busybox_unstripped<br>Trying libraries: crypt m<br>Failed: -Wl,--start-gro=
up -lcrypt -lm -Wl,--end-group<br>Output of:<br>powerpc-linux-gcc -Wall -Ws=
hadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-paramet=
er -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarat=
ions -Wdeclaration-after-statement -Wold-style-definition -fno-builtin-strl=
en -finline-limit=3D0 -fomit-frame-pointer -ffunction-sections -fdata-secti=
ons -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-fu=
nctions=3D1
 -falign-jumps=3D1 -falign-labels=3D1 -falign-loops=3D1 -Os -I/opt/mpc8250/=
tools/ppc_6xx/usr/include/ -L/opt/mpc8250/tools/ppc_6xx/usr/lib/ -static -n=
ostdlib -L/opt/mpc8250/tools/ppc_6xx/usr/lib/ -o busybox_unstripped -Wl,--s=
tart-group applets/built-in.o archival/lib.a archival/libunarchive/lib.a co=
nsole-tools/lib.a coreutils/lib.a coreutils/libcoreutils/lib.a debianutils/=
lib.a e2fsprogs/lib.a editors/lib.a findutils/lib.a init/lib.a libbb/lib.a =
libpwdgrp/lib.a loginutils/lib.a mailutils/lib.a miscutils/lib.a modutils/l=
ib.a networking/lib.a networking/libiproute/lib.a networking/udhcp/lib.a pr=
intutils/lib.a procps/lib.a runit/lib.a selinux/lib.a shell/lib.a sysklogd/=
lib.a util-linux/lib.a util-linux/volume_id/lib.a archival/built-in.o archi=
val/libunarchive/built-in.o console-tools/built-in.o coreutils/built-in.o c=
oreutils/libcoreutils/built-in.o debianutils/built-in.o e2fsprogs/built-in.=
o editors/built-in.o findutils/built-in.o init/built-in.o libbb/built-in.o
 libpwdgrp/built-in.o loginutils/built-in.o mailutils/built-in.o miscutils/=
built-in.o modutils/built-in.o networking/built-in.o networking/libiproute/=
built-in.o networking/udhcp/built-in.o printutils/built-in.o procps/built-i=
n.o runit/built-in.o selinux/built-in.o shell/built-in.o sysklogd/built-in.=
o util-linux/built-in.o util-linux/volume_id/built-in.o -Wl,--end-group -Wl=
,--start-group -lcrypt -lm -Wl,--end-group<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>/opt/mpc8250/tools/usr/bin/../lib/gcc/powerpc-linux/4.2.2/../../../.=
./powerpc-linux/bin/ld: cannot find -lcrypt<br>collect2: ld returned 1 exit=
 status<br>make: *** [busybox_unstripped] Error 1<br><br><br>Any clues as t=
o why this happens?<br><br>Thanks &amp; Regards,<br>D.Giriprasad<br><br></t=
d></tr></table><br>
--0-1800096128-1296106094=:87276--
