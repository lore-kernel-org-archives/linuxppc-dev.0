Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4EB96002.5030605@freescale.com>
References: <20111107044750.GB4361@in.ibm.com>
 <4EB812E8.9090107@freescale.com> <20111108065811.GA9109@in.ibm.com>
 <4EB96002.5030605@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature"; boundary="=-c32i3MHk0AFmrbwUuc8S"
Date: Wed, 09 Nov 2011 17:51:24 +1100
Message-ID: <1320821484.9376.9.camel@concordia>
Mime-Version: 1.0
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-c32i3MHk0AFmrbwUuc8S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-11-08 at 10:59 -0600, Scott Wood wrote:
> On 11/08/2011 12:58 AM, Ananth N Mavinakayanahalli wrote:
> > On Mon, Nov 07, 2011 at 11:18:32AM -0600, Scott Wood wrote:
> >> What use does userspace have for this?  If you want to return the
> >> currently executing CPU (which unless you're pinned could change as so=
on
> >> as the value is read...), why not just return smp_processor_id() or
> >> hard_smp_processor_id()?
> >=20
> > Its not just the current cpu. Decoding PIR can tell you the core id,
> > thread id in case of SMT, and this information can be used by userspace
> > apps to set affinities, etc.
>=20
> Wouldn't it make more sense to expose the thread to core mappings in a
> general way, not tied to hardware or what thread we're currently running =
on?

AFAIK that is already available in /sys/devices/system/cpu/cpuX/topology

cheers


--=-c32i3MHk0AFmrbwUuc8S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk66IuQACgkQdSjSd0sB4dL0NACeP2luzI5Nro0jiLLv7aWUetzu
yMwAnjujq0DbgHvq1Sl5AJCGW/xUvobF
=nUqO
-----END PGP SIGNATURE-----

--=-c32i3MHk0AFmrbwUuc8S--
