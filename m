Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A2DBCDE1AD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 02:08:42 +1000 (EST)
Date: Thu, 10 Jul 2008 02:08:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Updates to powerpc.git
Message-Id: <20080710020832.3e654bc9.sfr@canb.auug.org.au>
In-Reply-To: <7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
References: <1215588881.8970.358.camel@pasglop>
	<7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jul_2008_02_08_32_+1000_CSYGS5dt/O1XmSKv"
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Jul_2008_02_08_32_+1000_CSYGS5dt/O1XmSKv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kumar,

On Wed, 9 Jul 2008 07:58:38 -0500 Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> What is your intent with the 'master' branch?  I hope you do NOT plan =20
> on ever rebasing it.  I assume if a patch gets into master and we drop =20
> it you'll do a git-revert of it?

"Ever" is such a strong word.  Even Paul on occasion rebased his master
branch.  I see no reason why Ben could not run his master (or maybe
better named "test") branch as a place that patches come and go and his
"next" branch as something that never (or very rarely) gets rebased with
commits progressing from master (test) to next when he is satisfied with
them. People should then base further work in the "next" branch.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jul_2008_02_08_32_+1000_CSYGS5dt/O1XmSKv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh04oAACgkQjjKRsyhoI8yRxACdF/PTPQrJMJKdJhilXDErO5ix
4H4An22FHLNM02lkX5LW9OrNgkwibW0U
=in3h
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jul_2008_02_08_32_+1000_CSYGS5dt/O1XmSKv--
