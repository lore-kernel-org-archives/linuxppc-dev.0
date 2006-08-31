Return-Path: <Phil.Mathews@innocon.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CD18.BD33B4AE"
Subject: RE: Unable to build ELDK 4.0 
Date: Thu, 31 Aug 2006 12:13:11 -0400
Message-ID: <3E8081396F6B524BA2854E7FA3F16438042EB1DF@mail.innocon.com>
References: <20060831155857.35812352640@atlas.denx.de>
From: "Mathews, Phil" <Phil.Mathews@innocon.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6CD18.BD33B4AE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thu 8/31/2006 11:58 AM
To: Mathews, Phil
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Unable to build ELDK 4.0=20
=20
Dear Phil,

in message <3E8081396F6B524BA2854E7FA3F16438042EB1DB@mail.innocon.com> =
you wrote:
>=20
> I am attempting to build the ELDK kernel using the directions in
> /home/mathews/ELDK/ppc_6xx/usr/src/linux-2.6.15/README.  The makefile =
is

Please also RTFM: =
http://www.denx.de/wiki/DULG/Manual?stickboard=3Dyosemite ,
especially section "6.2. Kernel Configuration and Compilation":
http://www.denx.de/wiki/view/DULG/LinuxConfiguration#Section_6.2.

Note that I selected the DULG-version  for  a  board  for  which  2.6
kernel support is available.

> trying to execute powerPC code (fixdep) on my Pentium box.  Where can =
I
> get a X86 version of this program?

This is a consequence of wrong make commands.

> ##### Make attempt:
> mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15> make
> O=3D/home/name/build/kernel menuconfig

You must pass correct ARCH=3D and CROSS_COMPILE=3D arguments when =
running
make, i. e.

	make ARCH=3Dppc CROSS_COMPILE=3Dppc_6xx- ... menuconfig

etc. Also make sure to start from a clean  source  tree,  i.  e.  run
"make mrproper" to clean up before configuring your board.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A modem is a baudy house.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
------Follow Up-----
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

After doing "make mrproper" and again following the README file that =
came with ELDK:

env | grep -e ARCH -e COMPILE
ARCH=3Dppc
CROSS_COMPILE=3Dppc_6xx-

mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15> make =
O=3D/home/name/build/kernel menuconfig
  HOSTCC  scripts/basic/fixdep
In file included from =
/home/mathews/ELDK/usr/../ppc_6xx/usr/include/sys/socket.h:35,
                 from =
/home/mathews/ELDK/usr/../ppc_6xx/usr/include/netinet/in.h:24,
                 from =
/home/mathews/ELDK/usr/../ppc_6xx/usr/include/arpa/inet.h:23,
                 from =
/home/mathews/ELDK/ppc_6xx/usr/src/linux-2.6.15/scripts/basic/fixdep.c:11=
5:
/home/mathews/ELDK/usr/../ppc_6xx/usr/include/bits/socket.h:304:24: =
error: asm/socket.h: No such file or directory
make[2]: *** [scripts/basic/fixdep] Error 1
make[1]: *** [scripts_basic] Error 2
make: *** [menuconfig] Error 2

------_=_NextPart_001_01C6CD18.BD33B4AE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: Unable to build ELDK 4.0 </TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: Wolfgang Denk [<A =
HREF=3D"mailto:wd@denx.de">mailto:wd@denx.de</A>]<BR>
Sent: Thu 8/31/2006 11:58 AM<BR>
To: Mathews, Phil<BR>
Cc: Linuxppc-embedded@ozlabs.org<BR>
Subject: Re: Unable to build ELDK 4.0<BR>
<BR>
Dear Phil,<BR>
<BR>
in message =
&lt;3E8081396F6B524BA2854E7FA3F16438042EB1DB@mail.innocon.com&gt; you =
wrote:<BR>
&gt;<BR>
&gt; I am attempting to build the ELDK kernel using the directions =
in<BR>
&gt; /home/mathews/ELDK/ppc_6xx/usr/src/linux-2.6.15/README.&nbsp; The =
makefile is<BR>
<BR>
Please also RTFM: <A =
HREF=3D"http://www.denx.de/wiki/DULG/Manual?stickboard=3Dyosemite">http:/=
/www.denx.de/wiki/DULG/Manual?stickboard=3Dyosemite</A> ,<BR>
especially section &quot;6.2. Kernel Configuration and =
Compilation&quot;:<BR>
<A =
HREF=3D"http://www.denx.de/wiki/view/DULG/LinuxConfiguration#Section_6.2"=
>http://www.denx.de/wiki/view/DULG/LinuxConfiguration#Section_6.2</A>.<BR=
>
<BR>
Note that I selected the DULG-version&nbsp; for&nbsp; a&nbsp; =
board&nbsp; for&nbsp; which&nbsp; 2.6<BR>
kernel support is available.<BR>
<BR>
&gt; trying to execute powerPC code (fixdep) on my Pentium box.&nbsp; =
Where can I<BR>
&gt; get a X86 version of this program?<BR>
<BR>
This is a consequence of wrong make commands.<BR>
<BR>
&gt; ##### Make attempt:<BR>
&gt; mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15&gt; make<BR>
&gt; O=3D/home/name/build/kernel menuconfig<BR>
<BR>
You must pass correct ARCH=3D and CROSS_COMPILE=3D arguments when =
running<BR>
make, i. e.<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make ARCH=3Dppc =
CROSS_COMPILE=3Dppc_6xx- ... menuconfig<BR>
<BR>
etc. Also make sure to start from a clean&nbsp; source&nbsp; tree,&nbsp; =
i.&nbsp; e.&nbsp; run<BR>
&quot;make mrproper&quot; to clean up before configuring your board.<BR>
<BR>
Best regards,<BR>
<BR>
Wolfgang Denk<BR>
<BR>
--<BR>
Software Engineering:&nbsp; Embedded and Realtime Systems,&nbsp; =
Embedded Linux<BR>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: =
wd@denx.de<BR>
A modem is a baudy house.<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>
------Follow Up-----<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
After doing &quot;make mrproper&quot; and again following the README =
file that came with ELDK:<BR>
<BR>
env | grep -e ARCH -e COMPILE<BR>
ARCH=3Dppc<BR>
CROSS_COMPILE=3Dppc_6xx-<BR>
<BR>
mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15&gt; make =
O=3D/home/name/build/kernel menuconfig<BR>
&nbsp; HOSTCC&nbsp; scripts/basic/fixdep<BR>
In file included from =
/home/mathews/ELDK/usr/../ppc_6xx/usr/include/sys/socket.h:35,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; from =
/home/mathews/ELDK/usr/../ppc_6xx/usr/include/netinet/in.h:24,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; from =
/home/mathews/ELDK/usr/../ppc_6xx/usr/include/arpa/inet.h:23,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; from =
/home/mathews/ELDK/ppc_6xx/usr/src/linux-2.6.15/scripts/basic/fixdep.c:11=
5:<BR>
/home/mathews/ELDK/usr/../ppc_6xx/usr/include/bits/socket.h:304:24: =
error: asm/socket.h: No such file or directory<BR>
make[2]: *** [scripts/basic/fixdep] Error 1<BR>
make[1]: *** [scripts_basic] Error 2<BR>
make: *** [menuconfig] Error 2<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6CD18.BD33B4AE--
