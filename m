Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A26E1DDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 15:18:39 +1000 (EST)
Date: Fri, 13 Jun 2008 15:18:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/19] ibmveth: Automatically enable larger rx buffer
	pools for larger mtu
Message-Id: <20080613151834.8dbcaa14.sfr@canb.auug.org.au>
In-Reply-To: <20080612222249.GX30916@linux.vnet.ibm.com>
References: <20080612215312.GF30916@linux.vnet.ibm.com>
	<20080612222249.GX30916@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__13_Jun_2008_15_18_34_+1000_A_i89JqwjiWM73Rm"
Cc: netdev@vger.kernel.org, David, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Brian King <brking@linux.vnet.ibm.com>,
	Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__13_Jun_2008_15_18_34_+1000_A_i89JqwjiWM73Rm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Thu, 12 Jun 2008 17:22:49 -0500 Robert Jennings <rcj@linux.vnet.ibm.com>=
 wrote:
>
> +	/* Deactivate all the buffer pools so that the next loop can activate
> +	   only the buffer pools necessary to hold the new MTU */
> +	for(i =3D 0; i<IbmVethNumBufferPools; i++)

Please uses spaces after "for" and around binary operators.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__13_Jun_2008_15_18_34_+1000_A_i89JqwjiWM73Rm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhSAyoACgkQTgG2atn1QN+IFACeLp6arVU4HXSJZe9bgGn13EWD
j6cAnAnzXuR2RJet2xbzhTuj7kJebEWj
=nN5n
-----END PGP SIGNATURE-----

--Signature=_Fri__13_Jun_2008_15_18_34_+1000_A_i89JqwjiWM73Rm--
