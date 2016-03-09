Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC2S7.hotmail.com (dub004-omc2s7.hotmail.com
 [157.55.1.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 096271A0C51
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 11:27:05 +1100 (AEDT)
Message-ID: <DUB117-W1369999A718E6C0B33E4DC8C8B30@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_97f23ffb-5f82-4c98-b0eb-90022512b5aa_"
From: luigi burdo <intermediadc@hotmail.com>
To: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "matthew@a-eon.com" <matthew@a-eon.com>, Trevor Dickinson
 <contact@a-eon.com>, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: RE: Freescale P5020 cpu will be kvm-pr?
Date: Wed, 9 Mar 2016 01:27:00 +0100
In-Reply-To: <1457482205.5360.114.camel@buserror.net>
References: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>,
 <1457482205.5360.114.camel@buserror.net>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_97f23ffb-5f82-4c98-b0eb-90022512b5aa_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Scott=2C thanks for the reply=2Cabout: I don't know what you mean by "wo=
rking only on emb side".thru qemu 2.5 i can use only ppcemb as kvm not ppc6=
4 or ppc=20
Dont have the Kvm-pr is a really unhappy news=2C it means we will not have =
the opportunity to run for example Mol-kvm on  this machine.
about:KVM for e5500 uses hardware hypervisor featureslook like hypervisor i=
s disabled because the main Hardware is too young and need a better knowled=
ge.

Thanks for your time and infos
Luigi

> From: oss@buserror.net
> To: intermediadc@hotmail.com=3B linuxppc-dev@lists.ozlabs.org
> Date: Tue=2C 8 Mar 2016 18:10:05 -0600
> Subject: Re: Freescale P5020 cpu will be kvm-pr?
> CC: matthew@a-eon.com=3B contact@a-eon.com=3B chzigotzky@xenosoft.de
>=20
> On Mon=2C 2016-02-29 at 20:03 +0100=2C luigi burdo wrote:
> > Hi all=2C
> > sorry for this email but i need to ask to  Alexander Graf and Michael
> > Ellerman if will be possible have kvm and kvm-pr for the Freescale/Nix =
P5020
> > cpu .=20
>=20
> KVM for e5500 uses hardware hypervisor features.  PR-mode KVM is not
> supported.  Nested KVM is not supported.
>=20
> > We are testing a new desktop machine with this powerpc cpu classes
> > and right now we see kvm under qemu is working only on emb side=2C this
> > because the kernel
> > set the e5500 cpu as a emb and there is no an option for build the kern=
el
> > with book3s.
>=20
> p5020 uses an e5500 core which is book3e.  You cannot use a book3s kernel=
 with
> it.  Why would you want to?
>=20
> I don't know what you mean by "working only on emb side".
>=20
> -Scott
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
 		 	   		  =

--_97f23ffb-5f82-4c98-b0eb-90022512b5aa_
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
<body class=3D'hmmessage'><div dir=3D'ltr'>Hi Scott=2C thanks for the reply=
=2C<div>about:&nbsp=3BI don't know what you mean by "working only on emb si=
de".</div><div>thru qemu 2.5 i can use only ppcemb as kvm not ppc64 or ppc&=
nbsp=3B</div><div><br></div><div>Dont have the Kvm-pr is a really unhappy n=
ews=2C it means we will not have the opportunity to run&nbsp=3B</div><div>f=
or example Mol-kvm on &nbsp=3Bthis machine.</div><div><br></div><div>about:=
KVM for e5500 uses hardware hypervisor features</div><div>look like hypervi=
sor is disabled because the main Hardware is too young and need a better kn=
owledge.</div><div><br></div><div><br></div><div>Thanks for your time and i=
nfos</div><div><br></div><div>Luigi<br><div><div><br><div>&gt=3B From: oss@=
buserror.net<br>&gt=3B To: intermediadc@hotmail.com=3B linuxppc-dev@lists.o=
zlabs.org<br>&gt=3B Date: Tue=2C 8 Mar 2016 18:10:05 -0600<br>&gt=3B Subjec=
t: Re: Freescale P5020 cpu will be kvm-pr?<br>&gt=3B CC: matthew@a-eon.com=
=3B contact@a-eon.com=3B chzigotzky@xenosoft.de<br>&gt=3B <br>&gt=3B On Mon=
=2C 2016-02-29 at 20:03 +0100=2C luigi burdo wrote:<br>&gt=3B &gt=3B Hi all=
=2C<br>&gt=3B &gt=3B sorry for this email but i need to ask to  Alexander G=
raf and Michael<br>&gt=3B &gt=3B Ellerman if will be possible have kvm and =
kvm-pr for the Freescale/Nix P5020<br>&gt=3B &gt=3B cpu . <br>&gt=3B <br>&g=
t=3B KVM for e5500 uses hardware hypervisor features.  PR-mode KVM is not<b=
r>&gt=3B supported.  Nested KVM is not supported.<br>&gt=3B <br>&gt=3B &gt=
=3B We are testing a new desktop machine with this powerpc cpu classes<br>&=
gt=3B &gt=3B and right now we see kvm under qemu is working only on emb sid=
e=2C this<br>&gt=3B &gt=3B because the kernel<br>&gt=3B &gt=3B set the e550=
0 cpu as a emb and there is no an option for build the kernel<br>&gt=3B &gt=
=3B with book3s.<br>&gt=3B <br>&gt=3B p5020 uses an e5500 core which is boo=
k3e.  You cannot use a book3s kernel with<br>&gt=3B it.  Why would you want=
 to?<br>&gt=3B <br>&gt=3B I don't know what you mean by "working only on em=
b side".<br>&gt=3B <br>&gt=3B -Scott<br>&gt=3B <br>&gt=3B <br>&gt=3B ______=
_________________________________________<br>&gt=3B Linuxppc-dev mailing li=
st<br>&gt=3B Linuxppc-dev@lists.ozlabs.org<br>&gt=3B https://lists.ozlabs.o=
rg/listinfo/linuxppc-dev<br></div></div></div></div> 		 	   		  </div></bod=
y>
</html>=

--_97f23ffb-5f82-4c98-b0eb-90022512b5aa_--
