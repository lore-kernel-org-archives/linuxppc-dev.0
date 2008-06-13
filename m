Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 66E42DDEDB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 15:25:08 +1000 (EST)
Date: Fri, 13 Jun 2008 15:25:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 17/19] ibmveth: enable driver for CMO
Message-Id: <20080613152502.b2bebcf4.sfr@canb.auug.org.au>
In-Reply-To: <20080612222311.GY30916@linux.vnet.ibm.com>
References: <20080612215312.GF30916@linux.vnet.ibm.com>
	<20080612222311.GY30916@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__13_Jun_2008_15_25_02_+1000_H4c4uuvX8DHU8EgX"
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

--Signature=_Fri__13_Jun_2008_15_25_02_+1000_H4c4uuvX8DHU8EgX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Thu, 12 Jun 2008 17:23:11 -0500 Robert Jennings <rcj@linux.vnet.ibm.com>=
 wrote:
>
> +	if(adapter->bounce_buffer !=3D NULL) {

Space after "if".  Here and elsewhere.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__13_Jun_2008_15_25_02_+1000_H4c4uuvX8DHU8EgX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhSBK4ACgkQTgG2atn1QN9XtgCfdc+IB4X88HuALojEz80jJm1T
Vv8AoIyl4yui89WrCRb5rfMszOCLRCPf
=crz+
-----END PGP SIGNATURE-----

--Signature=_Fri__13_Jun_2008_15_25_02_+1000_H4c4uuvX8DHU8EgX--
