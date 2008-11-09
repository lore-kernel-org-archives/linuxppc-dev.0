Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2D026DDDED
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 11:17:12 +1100 (EST)
Date: Sun, 9 Nov 2008 11:17:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Updated Freescale PPC related defconfigs
Message-Id: <20081109111705.2ad97684.sfr@canb.auug.org.au>
In-Reply-To: <1226169747-3414-1-git-send-email-galak@kernel.crashing.org>
References: <1226169747-3414-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__9_Nov_2008_11_17_05_+1100_4j8ztLVqpAUPsK+W"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__9_Nov_2008_11_17_05_+1100_4j8ztLVqpAUPsK+W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Sat,  8 Nov 2008 12:42:27 -0600 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> unset CONFIG_PCI_LEGACY in the defconfigs as none of them enable
> ISDN drivers which seem to be the only place we are using pci_find_device

Than you very much!  :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__9_Nov_2008_11_17_05_+1100_4j8ztLVqpAUPsK+W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkWLAEACgkQjjKRsyhoI8yYjQCgmXhkRGUzJ/15LZL7zVwXRRx4
5bIAn0OdFmp1sJdGfERuedQ3/7SlN7ca
=6chN
-----END PGP SIGNATURE-----

--Signature=_Sun__9_Nov_2008_11_17_05_+1100_4j8ztLVqpAUPsK+W--
