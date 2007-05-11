Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 96820DDF05
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 21:04:38 +1000 (EST)
Date: Fri, 11 May 2007 21:04:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2] 83xx USB platform code rework
Message-Id: <20070511210432.ffdbd928.sfr@canb.auug.org.au>
In-Reply-To: <464434CB.7020706@freescale.com>
References: <464434CB.7020706@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_May_2007_21_04_32_+1000_qhebWBX7oBQRM5c8"
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_May_2007_21_04_32_+1000_qhebWBX7oBQRM5c8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 11 May 2007 17:18:03 +0800 Li Yang <leoli@freescale.com> wrote:
>
> +
> +		prop = get_property(np, "phy_type", NULL);
                       ^^^^^^^^^^^^
get_property has been renamed ot of_get_property ...

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_May_2007_21_04_32_+1000_qhebWBX7oBQRM5c8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRE3FFdBgD/zoJvwRAlk6AJ9Vl3De+7x/zgTMhb4uW48xlH2TuwCfRozj
rbWJqJCxH0h2I4t9CwiktoY=
=a+Yv
-----END PGP SIGNATURE-----

--Signature=_Fri__11_May_2007_21_04_32_+1000_qhebWBX7oBQRM5c8--
