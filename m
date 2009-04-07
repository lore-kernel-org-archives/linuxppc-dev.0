Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4AA57DDFB4
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 17:30:17 +1000 (EST)
Date: Tue, 7 Apr 2009 17:30:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Subrata Modak <tosubrata@gmail.com>
Subject: Re: [PATCH] powerpc: wire up preadv and pwritev
Message-Id: <20090407173003.1491e580.sfr@canb.auug.org.au>
In-Reply-To: <bb33bcf20904062351p63645851h9b33d47f57c57e7f@mail.gmail.com>
References: <20090407131950.9ab4430b.sfr@canb.auug.org.au>
	<bb33bcf20904062351p63645851h9b33d47f57c57e7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__7_Apr_2009_17_30_03_+1000_SEVMIJzZp4v72qzE"
Cc: ltp-list <ltp-list@lists.sf.net>, maknayak@in.ibm.com,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Gerd Hoffmann <kraxel@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__7_Apr_2009_17_30_03_+1000_SEVMIJzZp4v72qzE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Subrata,

On Tue, 7 Apr 2009 12:21:18 +0530 Subrata Modak <tosubrata@gmail.com> wrote:
>
> How about contributing the above test to LTP(http://ltp.sourceforge.net/)
> under GPL ? If you agree, i would soon send you a Patch integrating the s=
ame
> to LTP.

I have no problem with that.  However, the test was originally written by
Gerd Hoffmann and is essentially unchanged (i just updated some details),
so I think that is where you should direct your request.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__7_Apr_2009_17_30_03_+1000_SEVMIJzZp4v72qzE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknbAPsACgkQjjKRsyhoI8w5iQCeJWQKbSS87I0eMLgXksFdm47Y
oYsAn1/hQ2UNCZ2lSazydBc06+7hrAbZ
=bDbb
-----END PGP SIGNATURE-----

--Signature=_Tue__7_Apr_2009_17_30_03_+1000_SEVMIJzZp4v72qzE--
