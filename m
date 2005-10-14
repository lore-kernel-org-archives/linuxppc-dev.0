Return-Path: <som_kadam1@rediffmail.com>
Received: from rediffmail.com (unknown [202.54.124.179])
	by ozlabs.org (Postfix) with SMTP id 500D868576
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Oct 2005 18:29:06 +1000 (EST)
Date: 14 Oct 2005 08:22:20 -0000
Message-ID: <20051014082220.32133.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
To: linuxppc-embedded@ozlabs.org
Content-type: multipart/alternative;
	boundary="Next_1129278140---0-202.54.124.179-32112"
Subject: ramdisk image, unable to mount fs 01:00
Reply-To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 This is a multipart mime message


--Next_1129278140---0-202.54.124.179-32112
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi , =0A=0A  i got linux-2.4.25 from denx devel cvs kernel , when i try to =
mount thr root fs , kernel panics giving the down message , =0Ai have used =
tis ramdisk image for 2.4.18 stock kernel , =0Acant i use the same ramdisk =
as i have compiled kernel using the same compiler , ?=0Aif not is that i ha=
ve to create a new ramdisk image ?=0A please throw some light on this =0ATh=
anks In Advance =0A=0ANeelu =0A--------------------------------------------=
-----------=0A=0A=3D> bootm 0x500000 0x600000                              =
                       =0A## Booting image at 00500000 ...                 =
                              =0A   Image Name:   Linux-2.4.25             =
                                     =0A   Image Type:   PowerPC Linux Kern=
el Image (gzip compressed)                  =0A   Data Size:    473290 Byte=
s =3D 462.2 kB                                       =0A   Load Address: 00=
000000                                                      =0A   Entry Poi=
nt:  00000000                                                      =0A   Ve=
rifying Checksum ... OK                                                   =
=0A   Uncompressing Kernel Image ... OK                                    =
       =0A## Loading RAMDisk Image at 00600000 ...                         =
              =0A   Image Name:   Test Ramdisk Image                       =
                     =0A   Image Type:   PowerPC Linux RAMDisk Image (gzip =
compressed)                 =0A   Data Size:    939123 Bytes =3D 917.1 kB  =
                                     =0A   Load Address: 00000000          =
                                            =0A   Entry Point:  00000000   =
                                                   =0A   Verifying Checksum=
 ... OK                                                   =0A   Loading Ram=
disk to 03eb8000, end 03f9d473 ... OK                            =0A   Tran=
sferring control to Linux (at address 00000000) ...                     =0A=
Liven 25 (@radop)  ver 2.92001 (ree)) Fri 14 1:32 2005 nodtotaes: 4 =0A----=
---------------------------------------------------------------------------=
---
--Next_1129278140---0-202.54.124.179-32112
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHi , <BR>=0A<BR>=0A&nbsp; i got linux-2.4.25 from denx devel cvs kern=
el , when i try to mount thr root fs , kernel panics giving the down messag=
e , <BR>=0Ai have used tis ramdisk image for 2.4.18 stock kernel , <BR>=0Ac=
ant i use the same ramdisk as i have compiled kernel using the same compile=
r , ?<BR>=0Aif not is that i have to create a new ramdisk image ?<BR>=0A pl=
ease throw some light on this <BR>=0AThanks In Advance <BR>=0A<BR>=0ANeelu =
<BR>=0A-------------------------------------------------------<BR>=0A<BR>=
=0A=3D&gt; bootm 0x500000 0x600000&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A#=
# Booting image at 00500000 ...&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A&nbsp;  Image Name:&nbsp;=
  Linux-2.4.25&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0A&nbsp;  Image Type:&nbsp;  Po=
werPC Linux Kernel Image (gzip compressed)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0A&nbsp;  Data Size:&nbsp; &nbsp; 473290=
 Bytes =3D 462.2 kB&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;  <BR>=0A&nbsp;  Load Address: 00000000&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; <BR>=0A&nbsp;  Entry Point:&nbsp; 00000000&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; <BR>=0A&nbsp;  Verifying Checksum ... OK&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
 <BR>=0A&nbsp;  Uncompressing Kernel Image ... OK&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A## Loading RAMDisk Im=
age at 00600000 ...&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;  <BR>=0A&nbsp;  Image Name:&nbsp;  Test Ramdisk Image&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0A&nbsp;  I=
mage Type:&nbsp;  PowerPC Linux RAMDisk Image (gzip compressed)&nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A&nbsp;  Data Size:&nbsp=
; &nbsp; 939123 Bytes =3D 917.1 kB&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;  <BR>=0A&nbsp;  Load Address: 00000000&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; <BR>=0A&nbsp;  Entry Point:&nbsp; 00000000&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; <BR>=0A&nbsp;  Verifying Checksum ... OK&nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;  <BR>=0A&nbsp;  Loading Ramdisk to 03eb8000, end 03f9d473 ..=
. OK&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; <BR>=0A&nbsp;  Transferring control to Linux (at=
 address 00000000) ...&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;  <BR>=0ALiven 25 (@radop)&nbsp; ver 2.92001 (ree)) Fri 14 =
1:32 2005 nodtotaes: 4 <BR>=0A---------------------------------------------=
-------------------------------------=0A</P>=0A<br><br>=0A<a href=3D"http:/=
/adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signature-h=
ome.htm/1507191490@Middle5?PARTNER=3D3"><IMG SRC=3D"http://adworks.rediff.c=
om/cgi-bin/AdWorks/sigimpress.cgi/www.rediff.com/signature-home.htm/1963059=
423@Middle5?OAS_query=3Dnull&PARTNER=3D3" BORDER=3D0 VSPACE=3D0 HSPACE=3D0>=
</a>=0A
--Next_1129278140---0-202.54.124.179-32112--
