Return-Path: <lk.atwork@yahoo.com>
Received: from n67.bullet.mail.sp1.yahoo.com (n67.bullet.mail.sp1.yahoo.com
	[98.136.44.47]) by ozlabs.org (Postfix) with SMTP id 80087DE162
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 08:36:25 +1000 (EST)
Date: Tue, 2 Sep 2008 15:36:17 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: Compile new kernel for 5200B w/ ELDK
To: =?iso-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-57730028-1220394977=:36930"
Message-ID: <560405.36930.qm@web46310.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-57730028-1220394977=:36930
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I had the same problem as you.=0A=0AFor what its worth, here is what I adde=
d to the end of my .dts file to get my console working for a MPC8347 embedd=
ed systems=0A=0Achosen {=0A        linux,stdout-path =3D &serial0;=0A};=0A=
=0AAlso, since I use uboot and not OF, I load the cuImage file instead of t=
he uImage file=0A=0A=0Athanks=0ALK=0A=0A=0A----- Original Message ----=0AFr=
om: Albrecht Dre=DF <albrecht.dress@arcor.de>=0ATo: linuxppc-embedded@ozlab=
s.org=0ASent: Tuesday, September 2, 2008 10:18:15 AM=0ASubject: Re: Compile=
 new kernel for 5200B w/ ELDK=0A=0AHi Detlev:=0A=0AAm 01.09.08 16:42 schrie=
b(en) Detlev Zundel:=0A> Use a recent kernel version.  2.6.26 should work o=
ut of the box  =0A> without too much hassle.  Some of the older versions ha=
d problems  =0A> effectively stalling Linux very early without any output o=
n the  =0A> console.=0A=0AThanks a lot for your hint, but unfortunately it =
doesn't solve my  =0Aproblem:=0A- downloaded 2.6.26.3 from kernel.org;=0A- =
called "make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx-  =0A52xx/lite5200b_def=
config";=0A- called "make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- uImage".=
=0A=0AHowever, even with "console=3DttyPSC0,115200 verbose panic=3D1" in th=
e  =0Abootargs, the kernel simply doesn't say /anything/ after decompressio=
n:=0A=0A<snip>=0A=3D> bootm=0A## Booting kernel from Legacy Image at 010000=
00 ...=0A    Image Name:   Linux-2.6.26.3=0A    Created:      2008-09-02   =
9:11:12 UTC=0A    Image Type:   PowerPC Linux Kernel Image (gzip compressed=
)=0A    Data Size:    1341904 Bytes =3D  1.3 MB=0A    Load Address: 0000000=
0=0A    Entry Point:  00000000=0A    Verifying Checksum ... OK=0A    Uncomp=
ressing Kernel Image ... OK=0A</snip>=0A=0ADo I understand the remark in  =
=0ADocumentation/powerpc/booting-without-of.txt, section "The /chosen  =0An=
ode", correctly that it is *not* necessary to add it to the dts file  =0Aas=
 u-boot 1.3.4 should fill it in automatically?  Anyway, adding this  =0Asec=
tion doesn't change anything...=0A=0AHELP!  I'm really lost here...=0A=0ATh=
anks, Albrecht.=0A=0A=0A=0A      
--0-57730028-1220394977=:36930
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>I had the same problem as you.<br><br>For what its wor=
th, here is what I added to the end of my .dts file to get my console worki=
ng for a MPC8347 embedded systems<br><br>chosen {<br>&nbsp; &nbsp; &nbsp; &=
nbsp; linux,stdout-path =3D &amp;serial0;<br>};<br><br>Also, since I use ub=
oot and not OF, I load the cuImage file instead of the uImage file<br></div=
><div style=3D"font-family: times new roman,new york,times,serif; font-size=
: 12pt;"><br>thanks<br>LK<br><br><div style=3D"font-family: arial,helvetica=
,sans-serif; font-size: 12pt;">----- Original Message ----<br>From: Albrech=
t Dre=DF &lt;albrecht.dress@arcor.de&gt;<br>To: linuxppc-embedded@ozlabs.or=
g<br>Sent: Tuesday, September 2, 2008 10:18:15 AM<br>Subject: Re: Compile n=
ew kernel for 5200B w/ ELDK<br><br>=0AHi Detlev:<br><br>Am 01.09.08 16:42 s=
chrieb(en) Detlev Zundel:<br>&gt; Use a recent kernel version.&nbsp; 2.6.26=
 should work out of the box&nbsp; <br>&gt; without too much hassle.&nbsp; S=
ome of the older versions had problems&nbsp; <br>&gt; effectively stalling =
Linux very early without any output on the&nbsp; <br>&gt; console.<br><br>T=
hanks a lot for your hint, but unfortunately it doesn't solve my&nbsp; <br>=
problem:<br>- downloaded 2.6.26.3 from <a target=3D"_blank" href=3D"http://=
kernel.org">kernel.org</a>;<br>- called "make ARCH=3Dpowerpc CROSS_COMPILE=
=3Dppc_6xx-&nbsp; <br>52xx/lite5200b_defconfig";<br>- called "make ARCH=3Dp=
owerpc CROSS_COMPILE=3Dppc_6xx- uImage".<br><br>However, even with "console=
=3DttyPSC0,115200 verbose panic=3D1" in the&nbsp; <br>bootargs, the kernel =
simply doesn't say /anything/ after decompression:<br><br>&lt;snip&gt;<br>=
=3D&gt; bootm<br>## Booting kernel from Legacy Image at 01000000 ...<br>&nb=
sp; &nbsp; Image Name:&nbsp;=20
 Linux-2.6.26.3<br>&nbsp; &nbsp; Created:&nbsp; &nbsp; &nbsp; 2008-09-02&nb=
sp;  9:11:12 UTC<br>&nbsp; &nbsp; Image Type:&nbsp;  PowerPC Linux Kernel I=
mage (gzip compressed)<br>&nbsp; &nbsp; Data Size:&nbsp; &nbsp; 1341904 Byt=
es =3D&nbsp; 1.3 MB<br>&nbsp; &nbsp; Load Address: 00000000<br>&nbsp; &nbsp=
; Entry Point:&nbsp; 00000000<br>&nbsp; &nbsp; Verifying Checksum ... OK<br=
>&nbsp; &nbsp; Uncompressing Kernel Image ... OK<br>&lt;/snip&gt;<br><br>Do=
 I understand the remark in&nbsp; <br>Documentation/powerpc/booting-without=
-of.txt, section "The /chosen&nbsp; <br>node", correctly that it is *not* n=
ecessary to add it to the dts file&nbsp; <br>as u-boot 1.3.4 should fill it=
 in automatically?&nbsp; Anyway, adding this&nbsp; <br>section doesn't chan=
ge anything...<br><br>HELP!&nbsp; I'm really lost here...<br><br>Thanks, Al=
brecht.<br></div></div></div><br>=0A=0A=0A=0A      </body></html>
--0-57730028-1220394977=:36930--
