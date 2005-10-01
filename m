Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 1 Oct 2005 12:17:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <kumar.gala@freescale.com>
Message-Id: <20051001121714.1b5886aa.sfr@canb.auug.org.au>
In-Reply-To: <52E29A49-AAF2-4E61-AAB2-CD02ABCBE447@freescale.com>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
	<20051001000001.1f1d8c48.sfr@canb.auug.org.au>
	<52E29A49-AAF2-4E61-AAB2-CD02ABCBE447@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__1_Oct_2005_12_17_14_+1000_xDr8=odW.5tNhsrT"
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/9] powerpc: merge idle_power4.S and fixup traps.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__1_Oct_2005_12_17_14_+1000_xDr8=odW.5tNhsrT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Sep 2005 15:52:40 -0500 Kumar Gala <kumar.gala@freescale.com> wr=
ote:
>
> (My first attempt at posting to the list failed due to size)

Yes, quoting the whole patch was probably not necessary :-)

> I really dont like the ideal of splitting up traps.c into traps32.c =20
> and traps64.c.  This defeats the purpose of the merge.  I expect that =20
> a significant portion of traps.c is common (or can be made to be) =20
> between all powerpc's.

My first attempt at the merge was a real mess and a right pain, so I put
the two files in as a compromise.  However, I have made another attempt
and ,although it took a while,  it seems to be going ok.  How about we put
the two in for now (as that will allow the merge of more platforms to
continue) and I will supply a further patch in a few days that combines
the two trapsxx.c files?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__1_Oct_2005_12_17_14_+1000_xDr8=odW.5tNhsrT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPfGqFdBgD/zoJvwRAkCfAJ0RIE2up8og37vVqNBw8xxrMFR7EACcDYjj
VOeuYbrRD90Dd+RjSRSNcHQ=
=zebT
-----END PGP SIGNATURE-----

--Signature=_Sat__1_Oct_2005_12_17_14_+1000_xDr8=odW.5tNhsrT--
