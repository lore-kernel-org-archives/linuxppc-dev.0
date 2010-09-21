Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 83132B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 11:00:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Generating elf kernel ?
Date: Tue, 21 Sep 2010 03:00:40 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8BD2F@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <20100920104353.5dbd9201@udp111988uds.am.freescale.net>
References: <201009141053.11946.dargaud@lpsc.in2p3.fr><20100914125713.GB5768@radix50.net><201009151007.50706.dargaud@lpsc.in2p3.fr><4C90835E.4050803@windriver.com><20100915114912.06bc7ed1@schlenkerla.am.freescale.net><4C9182EC.5030900@windriver.com><20100916120944.11c45c31@schlenkerla.am.freescale.net><4C92CB51.5010008@windriver.com><20100917124448.255b08cc@schlenkerla.am.freescale.net><4C9569FF.6090807@windriver.com>
	<20100920104353.5dbd9201@udp111988uds.am.freescale.net>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]=20
> Sent: Monday, September 20, 2010 11:44 PM
> To: Chen, Tiejun
> Cc: linuxppc-dev@lists.ozlabs.org; Guillaume Dargaud
> Subject: Re: Generating elf kernel ?
>=20
> On Sun, 19 Sep 2010 09:40:15 +0800
> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
>=20
> > Scott Wood wrote:
> > > On Fri, 17 Sep 2010 09:58:41 +0800
> > > "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> > >=20
> > >> Scott Wood wrote:
> > >>> The guest OS *is* the same as native Linux, as far as=20
> TLB handling=20
> > >>> is concerned.
> > >> Looks you means the TLB exception handler should be same between=20
> > >> the native and the guest OS. Right?
> > >=20
> > > Yes.
> >=20
> > I don't think so. The HY should assist the guest OS on MMU since I=20
> > already point the guest OS have no authority to create a=20
> real TLB directly as I previously said.
>=20
> Of course the hypervisor assists, when a trap is taken.  That=20
> doesn't mean the code is any different in the guest.

This should be depend on the hypervisor design implementation. I think
your=20
option should be based on the Freescale hypervisor.

>=20
> > > Yes, of course.  But that's not the point.  I was just=20
> using it as a=20
> > > convenient example because that's what I've recently done ELF=20
> > > loading with...  There's no reason U-Boot couldn't do the same if=20
> > > its ELF loader were updated to support device trees.  Currently=20
> > > U-Boot loads bootwrapperless uImages to physical address zero.
> >=20
> > I never doubt the U-boot can do this for uImage. But I think we're=20
> > always talking about vmlinux, a bare Image.
>=20
> uImage is pretty much a bare image.  It just has a header=20
> with a checksum and some info like OS/architecture, kernel=20
> version, build date, etc.

Yes. But it also inlcude load address and entry point used to u-boot.

>=20
> There would be *no* problem doing this with vmlinux in U-Boot=20
> if someone put in the code to pass a device tree.

This is just I always emphasize previously.

Cheers
Tiejun

>=20
> -Scott
>=20
>=20
