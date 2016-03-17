Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC2S1.hotmail.com (dub004-omc2s1.hotmail.com
 [157.55.1.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQxcZ51WSzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 05:25:50 +1100 (AEDT)
Message-ID: <DUB117-W205C0CF615930A9F3C698AC88B0@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_88ff3ace-68cc-45dd-8525-3a7fbab7eab3_"
From: luigi burdo <intermediadc@hotmail.com>
To: Scott Wood <oss@buserror.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "matthew@a-eon.com" <matthew@a-eon.com>, Trevor Dickinson
 <contact@a-eon.com>, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: RE: Freescale P5020 cpu will be kvm-pr?
Date: Thu, 17 Mar 2016 19:25:44 +0100
In-Reply-To: <1458231790.19333.7.camel@buserror.net>
References: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>, ,
 <1457482205.5360.114.camel@buserror.net>, ,
 <DUB117-W1369999A718E6C0B33E4DC8C8B30@phx.gbl>, ,
 <DUB117-W6931726DAC4EB1D528591DC8B40@phx.gbl>, ,
 <1458081467.12370.31.camel@buserror.net>, ,
 <DUB406-EAS2759FE0784777D029FB586BC88A0@phx.gbl>, ,
 <1458186445.19333.3.camel@buserror.net>,
 <DUB117-W90A8E7C5DFE0D4D6781F55C88B0@phx.gbl>,
 <1458231790.19333.7.camel@buserror.net>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_88ff3ace-68cc-45dd-8525-3a7fbab7eab3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Scott=2C
thank you very much for your infos are really appreciated
because let me know better this hardware=20

Kind regards
Luigi Burdo
AmigaOne X5000
beta Tester




> From: oss@buserror.net
> To: intermediadc@hotmail.com
> Date: Thu=2C 17 Mar 2016 11:23:10 -0500
> Subject: Re: Freescale P5020 cpu will be kvm-pr?
> CC: linuxppc-dev@lists.ozlabs.org=3B matthew@a-eon.com=3B contact@a-eon.c=
om=3B chzigotzky@xenosoft.de
>=20
> On Thu=2C 2016-03-17 at 14:38 +0100=2C luigi burdo wrote:
> > Hi Scott=2C
> > this is my Kernel 4.5 dmesg=20
> >=20
> > dmesg | grep -i MMU
> > [    0.000000] MMU: Supported page sizes
> > [    0.000000] MMU: Book3E HW tablewalk not supported
> > [    0.000000] mmu_features      =3D 0x000a0010
> > [    0.000000] MMU: Allocated 2112 bytes of context maps for 255 contex=
ts
> >=20
> > dmesg | grep -i e500
> > [    0.001787] e500 family performance monitor hardware support registe=
red
> >=20
> >=20
> >  dmesg | grep -i hypervisor
> >=20
> > [    0.396726] ePAPR hypervisor byte channel driver
> > [    3.240020] Freescale hypervisor management driver
> > [    3.240024] fsl-hv: no hypervisor found
>=20
> None of these messages are a problem.
>=20
> "Book3E HW tablewalk" is for e6500=2C not e5500.  fsl-hv is for the Frees=
cale
> Embedded Hypervisor (Topaz)=2C not KVM.
>=20
>=20
> > i attached my kenrel .config
> >=20
> > My qemu-ppc-64 crash=2C note i have the same crash=20
> >=20
> > qemu: fatal: This KVM version does not support PAPR
>=20
> You need to tell QEMU to use the appropriate CPU type (e5500) and platfor=
m
> (ppce500).  PAPR is for book3s=2C which is what QEMU defaults to.
>=20
> -Scott
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
 		 	   		  =

--_88ff3ace-68cc-45dd-8525-3a7fbab7eab3_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Hi Scott=2C<br>thank you very mu=
ch for your infos are really appreciated<br>because let me know better this=
 hardware <br><br>Kind regards<br>Luigi Burdo<br>AmigaOne X5000<br>beta Tes=
ter<br><br><br><br><br><div>&gt=3B From: oss@buserror.net<br>&gt=3B To: int=
ermediadc@hotmail.com<br>&gt=3B Date: Thu=2C 17 Mar 2016 11:23:10 -0500<br>=
&gt=3B Subject: Re: Freescale P5020 cpu will be kvm-pr?<br>&gt=3B CC: linux=
ppc-dev@lists.ozlabs.org=3B matthew@a-eon.com=3B contact@a-eon.com=3B chzig=
otzky@xenosoft.de<br>&gt=3B <br>&gt=3B On Thu=2C 2016-03-17 at 14:38 +0100=
=2C luigi burdo wrote:<br>&gt=3B &gt=3B Hi Scott=2C<br>&gt=3B &gt=3B this i=
s my Kernel 4.5 dmesg <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B dmesg | grep -i M=
MU<br>&gt=3B &gt=3B [    0.000000] MMU: Supported page sizes<br>&gt=3B &gt=
=3B [    0.000000] MMU: Book3E HW tablewalk not supported<br>&gt=3B &gt=3B =
[    0.000000] mmu_features      =3D 0x000a0010<br>&gt=3B &gt=3B [    0.000=
000] MMU: Allocated 2112 bytes of context maps for 255 contexts<br>&gt=3B &=
gt=3B <br>&gt=3B &gt=3B dmesg | grep -i e500<br>&gt=3B &gt=3B [    0.001787=
] e500 family performance monitor hardware support registered<br>&gt=3B &gt=
=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B  dmesg | grep -i hypervisor<br>&gt=
=3B &gt=3B <br>&gt=3B &gt=3B [    0.396726] ePAPR hypervisor byte channel d=
river<br>&gt=3B &gt=3B [    3.240020] Freescale hypervisor management drive=
r<br>&gt=3B &gt=3B [    3.240024] fsl-hv: no hypervisor found<br>&gt=3B <br=
>&gt=3B None of these messages are a problem.<br>&gt=3B <br>&gt=3B "Book3E =
HW tablewalk" is for e6500=2C not e5500.  fsl-hv is for the Freescale<br>&g=
t=3B Embedded Hypervisor (Topaz)=2C not KVM.<br>&gt=3B <br>&gt=3B <br>&gt=
=3B &gt=3B i attached my kenrel .config<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B =
My qemu-ppc-64 crash=2C note i have the same crash <br>&gt=3B &gt=3B <br>&g=
t=3B &gt=3B qemu: fatal: This KVM version does not support PAPR<br>&gt=3B <=
br>&gt=3B You need to tell QEMU to use the appropriate CPU type (e5500) and=
 platform<br>&gt=3B (ppce500).  PAPR is for book3s=2C which is what QEMU de=
faults to.<br>&gt=3B <br>&gt=3B -Scott<br>&gt=3B <br>&gt=3B _______________=
________________________________<br>&gt=3B Linuxppc-dev mailing list<br>&gt=
=3B Linuxppc-dev@lists.ozlabs.org<br>&gt=3B https://lists.ozlabs.org/listin=
fo/linuxppc-dev<br></div> 		 	   		  </div></body>
</html>=

--_88ff3ace-68cc-45dd-8525-3a7fbab7eab3_--
