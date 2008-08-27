Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3E0C2DDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 00:38:28 +1000 (EST)
Date: Thu, 28 Aug 2008 00:38:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [BUG] linux-next: Tree for August 26 - Badness at
	kernel/notifier.c:25
Message-Id: <20080828003821.d29d2a03.sfr@canb.auug.org.au>
In-Reply-To: <20080828003308.400038e0.sfr@canb.auug.org.au>
References: <20080826184008.6be39f19.sfr@canb.auug.org.au>
	<48B44B2D.8070809@linux.vnet.ibm.com>
	<48B46610.1010809@linux.intel.com>
	<48B53695.3020703@linux.vnet.ibm.com>
	<48B55B16.7060804@linux.intel.com>
	<20080828003308.400038e0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__28_Aug_2008_00_38_21_+1000_JuofXQY0VMBWRnyG"
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__28_Aug_2008_00_38_21_+1000_JuofXQY0VMBWRnyG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arjan,

On Thu, 28 Aug 2008 00:33:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> The original reported trace was during setup_system which is very early in
> the boot.

But, of course, that version didn't have the necessary extra dereference
of the function address ...

And the later debug patch did not check the address at register time,
only at notify time.

The later trace also looks to be early in the boot.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Aug_2008_00_38_21_+1000_JuofXQY0VMBWRnyG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki1Zt0ACgkQjjKRsyhoI8zpLgCfarrleKfgA2cCG2ehQzSc2xXT
+jQAoIZUgAZcVwpfLDg2WzTl38oq9z16
=WTqy
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Aug_2008_00_38_21_+1000_JuofXQY0VMBWRnyG--
