Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1AD9FDDE42
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:44:54 +1000 (EST)
Date: Mon, 14 May 2007 10:44:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] viopath: use completion
Message-Id: <20070514104444.b8064b1e.sfr@canb.auug.org.au>
In-Reply-To: <20070513155027.GB9218@lst.de>
References: <20070513155027.GB9218@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_May_2007_10_44_44_+1000_M3lwMJ6rEqj3tLI5"
Cc: boutcher@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__14_May_2007_10_44_44_+1000_M3lwMJ6rEqj3tLI5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 13 May 2007 17:50:27 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> Use a completion instead of abusing a semaphore for hypervisor event
> completion in viopath.
>
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_May_2007_10_44_44_+1000_M3lwMJ6rEqj3tLI5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGR7EAFdBgD/zoJvwRAtBUAJ4j6b57vIP2zs6zQIfAXQ2nCGE/+QCfeCBb
Rtw001ffVrbaDTRZsirmElk=
=UTn7
-----END PGP SIGNATURE-----

--Signature=_Mon__14_May_2007_10_44_44_+1000_M3lwMJ6rEqj3tLI5--
