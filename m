Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6FCECDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 11:25:47 +1000 (EST)
Date: Thu, 7 Jun 2007 11:25:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 08/18] PS3: Kexec support
Message-Id: <20070607112541.5a296cd1.sfr@canb.auug.org.au>
In-Reply-To: <46672D34.8010808@am.sony.com>
References: <20070606024407.786638029@am.sony.com>
	<4666233F.1080103@am.sony.com>
	<1181102510.5536.15.camel@concordia.ozlabs.ibm.com>
	<46672D34.8010808@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__7_Jun_2007_11_25_41_+1000_JDqxYxSnpf0+gzR0"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__7_Jun_2007_11_25_41_+1000_JDqxYxSnpf0+gzR0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geoff,

On Wed, 06 Jun 2007 14:55:00 -0700 Geoff Levand <geoffrey.levand@am.sony.co=
m> wrote:
>
> Michael Ellerman wrote:
> > On Tue, 2007-06-05 at 20:00 -0700, Geoff Levand wrote:
> >> Fixup the core platform parts needed for kexec to work on the PS3.
> >>  - Setup ps3_hpte_clear correctly.
> >>  - Mask interrupts on irq removal.
> >>  - Release all hypervisor resources.
> >=20
> > The irq changes might be kexec related, but it's a mess to review. You
> > seem to moving a bunch of code around in the patch as well.
>=20
> Yes, I need to move the static chip_mask routines up so they would be
> defined before the irq setup/destroy routines.

I think Michael's point then is that if you submitted a separate
preceding patch that just moves stuff around without any other changes
(if at all possible) then reviewing the changes in this would be much
easier (and our confidence would be higher).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__7_Jun_2007_11_25_41_+1000_JDqxYxSnpf0+gzR0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGZ16aFdBgD/zoJvwRAgftAJ9RufFg+oRAkfe+3ELMLOEEgKqA3gCfdFoa
npgWfiC2IRnAaiiR1kGYXcU=
=qMga
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Jun_2007_11_25_41_+1000_JDqxYxSnpf0+gzR0--
