Return-Path: <michael@ellerman.id.au>
Subject: Re: [V2 PATCH 00/10] of: Consolidate scattered device node
	pointers in struct device
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100318144836.21082.93040.stgit@angua>
References: <20100318144836.21082.93040.stgit@angua>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-V6FOmiM8suhP22YvlFQu"
Date: Tue, 23 Mar 2010 17:57:04 +1100
Message-ID: <1269327424.5953.12.camel@concordia>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-V6FOmiM8suhP22YvlFQu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-03-18 at 09:22 -0600, Grant Likely wrote:
> Currently, each of_device has a copy of the device tree node pointer in b=
oth
> .node, and in .dev.archdata.of_node (microblaze and powerpc) or
> .dev.archdata.prom_node (sparc).  Also, other architectures will be addin=
g
> CONFIG_OF support, and they will also need a reference to the device tree
> node pointer from struct device.

Assuming this is similar to your experimental-devicetree branch, as of
96b4b9d7 it causes a few build errors for me:

http://kisskb.ellerman.id.au/kisskb/head/2688/

Broken are 86xx/sbc8641d_defconfig, mpc83xx_defconfig,
mpc885_ads_defconfig, mpc85xx_defconfig, and pmac32_defconfig.

I haven't dug any further.

cheers

--=-V6FOmiM8suhP22YvlFQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuoZkAACgkQdSjSd0sB4dId9ACfazgsVaXLGyHjh3bmJTAlR+Tg
QcYAn3+H90fVn8gZ3rvwDh+quQWxPO13
=YLDW
-----END PGP SIGNATURE-----

--=-V6FOmiM8suhP22YvlFQu--
