Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7223CDDEEE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 11:27:14 +1000 (EST)
Date: Thu, 17 May 2007 11:27:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix VDSO compile warning
Message-Id: <20070517112704.c4ec9330.sfr@canb.auug.org.au>
In-Reply-To: <11793283363025-git-send-email-segher@kernel.crashing.org>
References: <11793283363025-git-send-email-segher@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__17_May_2007_11_27_04_+1000_R3Xl440bqu7.Bty3"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__17_May_2007_11_27_04_+1000_R3Xl440bqu7.Bty3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 16 May 2007 17:12:16 +0200 Segher Boessenkool <segher@kernel.crashing.org> wrote:
>
> Maybe the type should have been char[] instead of __u8[]
> in the first place, but this will do.

What warning do you get?  What compiler version?

I don't get a warning using version 4.1.2 20061115 (prerelease) (Debian
4.1.1-21).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__17_May_2007_11_27_04_+1000_R3Xl440bqu7.Bty3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGS69xFdBgD/zoJvwRAntsAJ44ieZm5qwToc2B2ltLfeCdd3HFLACcD4iL
ROV7CTn6BqnJCWdOk4GKhw0=
=5536
-----END PGP SIGNATURE-----

--Signature=_Thu__17_May_2007_11_27_04_+1000_R3Xl440bqu7.Bty3--
