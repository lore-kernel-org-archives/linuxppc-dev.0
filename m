Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B9A2567B9E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 13:39:54 +1000 (EST)
Date: Wed, 18 Oct 2006 13:39:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Randy.Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2/2] viocons: make powerpc allmodconfig build
Message-Id: <20061018133947.20a2c84f.sfr@canb.auug.org.au>
In-Reply-To: <4535824F.1020407@oracle.com>
References: <20061017095003.c447d88a.randy.dunlap@oracle.com>
	<20061018111935.a143164c.sfr@canb.auug.org.au>
	<4535824F.1020407@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__18_Oct_2006_13_39_47_+1000_=tzQ/7bM4VBZDDi4"
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__18_Oct_2006_13_39_47_+1000_=tzQ/7bM4VBZDDi4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2006 18:24:31 -0700 "Randy.Dunlap" <randy.dunlap@oracle.com> wrote:
>
> OK.  Makes sense.  Will you just build VT in that combo *series
> config and not build VIOCONS?  If so, that would still fix
> "make allmodconfig" to build cleanly (I think).

Yes, VIOCONS is now obsolete (it is replaced by HVC_ISERIES which doesn't
clash with VT), but it is used by the distros so I don't want to remove
it (yet).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Oct_2006_13_39_47_+1000_=tzQ/7bM4VBZDDi4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFNaIDFdBgD/zoJvwRAuyUAJ9I4IR0KzcQiChIeikttwQjzGsFLACgmt07
alB87s7I5IuNJ51346UhyIg=
=AZzX
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Oct_2006_13_39_47_+1000_=tzQ/7bM4VBZDDi4--
