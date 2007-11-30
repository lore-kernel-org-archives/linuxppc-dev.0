Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 49385DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 16:57:01 +1100 (EST)
Date: Fri, 30 Nov 2007 16:56:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
Message-Id: <20071130165651.b1b7c16c.sfr@canb.auug.org.au>
In-Reply-To: <1196208960.11297.26.camel@farscape.rchland.ibm.com>
References: <20071120012815.GB7969@austin.ibm.com>
	<1196208960.11297.26.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__30_Nov_2007_16_56_51_+1100_H_b49cjAMBYZgQXO"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__30_Nov_2007_16_56_51_+1100_H_b49cjAMBYZgQXO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Nov 2007 18:15:59 -0600 Will Schmidt <will_schmidt@vnet.ibm.com>=
 wrote:
>
> (resending with the proper "from" addr this time).=20
>=20
>=20
> I'm seeing some funky behavior on power5/power6 partitions with this
> patch.    A "/sbin/reboot" is now behaving much more like a
> "/sbin/halt".
>=20
> Anybody else seeing this, or is it time for me to call an exorcist for
> my boxes?=20

On my Power5+ box, I get an error (code B200A101) logged every time I
reboot and about half the time, the machine does not reboot but need to
be power cycled. Removing the cited patch makes the error not by logged
and reboots work fine.

Paul and I have been having a look at this and Paul has asked the
architects for clarification of when os-term should be used.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__30_Nov_2007_16_56_51_+1100_H_b49cjAMBYZgQXO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHT6YpTgG2atn1QN8RAg2KAKCRNNcn5aA9Besh/fi5M6+XyUAPPwCeNXzZ
BGVY6N0XUNV0PQUes/HnqrY=
=bO/s
-----END PGP SIGNATURE-----

--Signature=_Fri__30_Nov_2007_16_56_51_+1100_H_b49cjAMBYZgQXO--
