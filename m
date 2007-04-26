Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 663BADDF00
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 15:54:41 +1000 (EST)
Date: Thu, 26 Apr 2007 15:54:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/6] Consolidate of_find_property
Message-Id: <20070426155449.187f3252.sfr@canb.auug.org.au>
In-Reply-To: <20070425.161309.02297897.davem@davemloft.net>
References: <1177539404.14873.199.camel@localhost.localdomain>
	<20070425.152419.110959714.davem@davemloft.net>
	<1177541265.14873.222.camel@localhost.localdomain>
	<20070425.161309.02297897.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__26_Apr_2007_15_54_49_+1000_U4GW/fBTLlQIsHIh"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__26_Apr_2007_15_54_49_+1000_U4GW/fBTLlQIsHIh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Dave,

On Wed, 25 Apr 2007 16:13:09 -0700 (PDT) David Miller <davem@davemloft.net> wrote:
>
> Meanwhile any feedback on the idea of pushing all of this
> consolidation and cleanup work through one of our trees
> instead of having all of these difficult dependencies
> between the two?

Seems the Linus has fixed this problem for us :-)

If you and Paul can get your for-2.6.22 trees pulled by Linus, I can
submit the remaining patches to Linus (with your and Paul's blessing, of
course).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__26_Apr_2007_15_54_49_+1000_U4GW/fBTLlQIsHIh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGMD66FdBgD/zoJvwRAtIKAJ9qfHhb4rdvgv8v7d65WUiFqgqQnQCeJzvC
NGZq4+vmn0jXSi20MgPzUag=
=EAhs
-----END PGP SIGNATURE-----

--Signature=_Thu__26_Apr_2007_15_54_49_+1000_U4GW/fBTLlQIsHIh--
