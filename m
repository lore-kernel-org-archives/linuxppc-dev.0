Return-Path: <francois.ruvoen@libertysurf.fr>
Received: from mail.libertysurf.net (webmail-out.tiscali.fr [213.36.80.105])
	by ozlabs.org (Postfix) with ESMTP id CE18C67A9D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 02:25:01 +1100 (EST)
Received: from tiscali.fr (192.168.10.56) by mail.libertysurf.net (7.1.026)
	id 41A46CD0002B96E8 for linuxppc-embedded@ozlabs.org;
	Mon, 7 Feb 2005 16:24:58 +0100
Date: Mon,  7 Feb 2005 16:24:58 +0100
Message-Id: <IBJS5M$14DAE0DC6D5C97F571F711EED9A5DF6A@tiscali.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "=?iso-8859-1?Q?francois.ruvoen@libertysurf.fr?="
	<francois.ruvoen@libertysurf.fr>
To: "=?iso-8859-1?Q?linuxppc-embedded?=" <linuxppc-embedded@ozlabs.org>
Subject: Re: Microwindows on Icecube/CoralP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks. Tweaking a little the source code and I now get the=0D=0Aright co=
lours. The funny thing is that byte swapping was:=0D=0A0x1234567 =3D> 0x3=
4126745. I initially thought I could just=0D=0Aswap the two least signifi=
cant bytes as I am pretty sure I=0D=0Aam using a 16-bit mode (fbset repor=
ts that anyway). Now I'd=0D=0Alike to see that in 640x480 and not just 10=
24x768 but that=0D=0Aissue seems tied the frame buffer driver this time.=0D=
=0A=0D=0A---------- Initial Header -----------=0D=0A=0D=0AFrom      : "Ma=
rk Chambers" <markc@mail.com>=0D=0ATo          :=0D=0A<francois.ruvoen@li=
bertysurf.fr>,"linuxppc-embedded"=0D=0A<linuxppc-embedded@ozlabs.org>=0D=0A=
Cc          : =0D=0ADate      : Mon, 7 Feb 2005 07:59:16 -0500=0D=0ASubje=
ct : Re: Microwindows on Icecube/CoralP=0D=0A=0D=0A=0D=0A>I have been pla=
ying with the CoralP, Icecube and Debian.=0D=0A>Works fine, thanks to the=
 tutorial on the Denx site.=0D=0A>I now would like to see the microwindow=
s stuff working. I=0D=0A>have been trying the demos from the ELDK but I g=
et strange=0D=0A>colors, it seems my palette is all wrong. The same happe=
ns=0D=0A>when I recompile the latest version of microwindows (except=0D=0A=
>I get yet another palette).=0D=0A>Any pointers?=0D=0A=0D=0AOne unexpecte=
d thing about the 5200 is that it swaps bytes=0D=0Ato/from the PCI buss. =
 So if you write a 32 bit pixel, for=0D=0Ainstance 0x12345678, it will be=
 written to PCI as=0D=0A0x78563412.  Presumably this is based on an assum=
ption=0D=0Athat PCI targets will be little-endian.  So you might try=0D=0A=
reversing bytes and see if the palettes make sense.=0D=0A=0D=0AMark Chamb=
ers=0D=0A=0D=0A=0D=0A=0A************************ ADSL JUSQU'A 16 MEGA + T=
ELEPHONE GRATUIT ************************=0AL'ultra haut d=E9bit =E0 30EU=
R/mois seulement ! Et vous t=E9l=E9phonez gratuitement en France vers les=
 postes fixes, hors num=E9ros sp=E9ciaux.=0APour profiter de cette offre =
exceptionnelle, cliquez ici : http://register.tiscali.fr/adsl/  (voir con=
ditions sur le site)=0A=0A
