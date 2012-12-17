Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 9A4DB2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2012 14:22:42 +1100 (EST)
Date: Mon, 17 Dec 2012 14:22:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build warning after merge of the final tree
Message-Id: <20121217142238.a0840563304419bb345ac25f@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__17_Dec_2012_14_22_38_+1100_85E9_IajO6cS+Kl3"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__17_Dec_2012_14_22_38_+1100_85E9_IajO6cS+Kl3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc allnoconfig)
produced this warning:

warning: (PPC) selects SPARSE_IRQ which has unmet direct dependencies (HAVE=
_GENERIC_HARDIRQS && (IRQ_DOMAIN && DEBUG_FS || MAY_HAVE_SPARSE_IRQ))

I don't know what introduced that.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__17_Dec_2012_14_22_38_+1100_85E9_IajO6cS+Kl3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQzo/+AAoJEECxmPOUX5FE0P4P/3zQxSNb+bPM8E7yin12ZsIF
Soc/tN4SGO7nMJYud64ar5yhk3POPwhy6jsLm97eNzHofVaFJBc9YmkBF+XY1RYR
+vi5JLeSDhx1RR/GlUY4lXTrN2fCZqlBDLb9b2QXzT/mCp/d0jDP5gMBqh98vzcc
fIF1lOBW4wYhjBh2YVXdT3x3CZham826j2U0YMABxf6xdqoZYSGxF+hcUHxvl/IJ
3QN2KDtXrnceufvkNCmnxYystu+++++dZK7KtiFD1Ug31Pfgka/PPwPT6QpN42t4
mxszJnDOCLc5YtlZWf/XV2+nUrHtpM0Cb6V2M6z5/Ugq3QgYzYYGbQnHLggA1ZKl
QZL4CckogOTxre16r9XBTIDSp4kIAo5ek+WcKiHajLCOz5ZsBO1zIZEgPVTpF4XR
aRdzGUq1SEBSMjMygtevkj6EcnNj3Dmgnz1IlCSf8F8aFQoRmVRhyCDavlNUExf0
Tl0Oj7rcImPwux30RcyanzBvBZGRkbABMq/NUJLzHS1mWZbg8EJvIhz4J1i0NiSO
g+GNOZ3J1qnkdiHN12Wmq5fZ73UwkLb/bQ7bWfNxo3qZ8QLo35KIvxwWrWgm6aue
pZ7Ahr9bvWfWpMSFWceg9qu6rq6s0X6dDMpgJfbMTl5u9ij1sKXN0B2mhM3vyO99
MZW4QkGeDh9UtWT9V09o
=DDnX
-----END PGP SIGNATURE-----

--Signature=_Mon__17_Dec_2012_14_22_38_+1100_85E9_IajO6cS+Kl3--
