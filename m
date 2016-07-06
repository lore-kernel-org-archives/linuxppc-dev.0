Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkpfT3Jl9zDqsQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:07:45 +1000 (AEST)
Date: Wed, 6 Jul 2016 15:09:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] Add KVM_CAP_PPC_HTM to linux/kvm.h
Message-ID: <20160706050934.GU2251@voom.fritz.box>
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
 <d2e391d1e0e381276ee2bff8e59d872c4b3bd2b5.1467695915.git.sam.bobroff@au1.ibm.com>
 <20160705060558.GL2251@voom.fritz.box>
 <20160706044152.GA5662@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qgEfXXHyyarqcYJd"
In-Reply-To: <20160706044152.GA5662@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qgEfXXHyyarqcYJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2016 at 02:41:52PM +1000, Sam Bobroff wrote:
> On Tue, Jul 05, 2016 at 04:05:58PM +1000, David Gibson wrote:
> > On Tue, Jul 05, 2016 at 03:19:23PM +1000, Sam Bobroff wrote:
> > > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> >=20
> > Ok, so the usual procedure for updates to linux-headers is this:
> >    1. Get the change merged on the kernel side
> >=20
> >    2. Use scripts/update-linux-headers.sh to update the whole
> >       linux-headers subtree to the new kernel version
> >=20
> >    3. Submit the patch - make sure to include the commit id of the
> >       kernel you updated to in the qemu commit message
>=20
> Thanks,
>=20
> Do you think we're at the point with this patch set that I should start
> progressing the kernel side change now?

Yes.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qgEfXXHyyarqcYJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfJKOAAoJEGw4ysog2bOS26QQAKS51qQnq4d9F9kSWLceVWGZ
EUehh6JsNoNupsbM9bNXhgUGSOUXKGqnI4KqMOf12qK0YW6TiUiJaU5uRZUb8+xC
kP5a2EAKdyXZfvM9ZuqSVV3T3/PaM2DMp82BLkFi7qoLUyo8Dnp/H/eelmxh+jvf
o01dKXHs2ciOvpxi9VW8q5Hhj0/ZinqvysZ/FZU8XqvF7u1Lk8VN9IkjSpWY32GD
kISRJG2rQP4N3aNPhZq2HNbd078rFarpKsisdwZ5v5hqsASqyxR/7Y50iUBi1eV8
onxo/7NP1N1K0++DtdtsUZ9T+dX7Fy6AUjd+GtkbzqqC6mrw2Y86C5Qey61ePjSW
rObhgz2EO+XE+kfSxHTQeOP/k7knOtwdOwBvsW7jERKs8VvH0v8UOaC9Lv1Ev48J
fibhtR3XyDiyqCQH2+10jUK28JHRRqFQM5zM8JYMN04UNlIBKpVoyIOaUHAjpB6q
D+SNeYjpCVO9HXSThyfgtBk1BeAPi1s0QYTiDP4ozIpkoQR7opQJoMm5rtBC1SAy
5nNZc7/MUnoa9aXDoZr7CrIoMQXBeGQxedTNvF8Yjduj1NXXHpCKVnBSoFww8vaY
vl5buopBABggfmSCSoBmaHX08xDFZskmOE/O3CskXZAN9qAsl/8ZDCrfk7HWNMGg
seAr5XHJGPvchfdpEqMP
=NWLY
-----END PGP SIGNATURE-----

--qgEfXXHyyarqcYJd--
