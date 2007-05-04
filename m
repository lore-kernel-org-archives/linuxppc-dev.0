Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A82F2DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 13:40:18 +1000 (EST)
Date: Fri, 4 May 2007 13:39:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH v3] powerpc: Show current speed in /proc/cpuinfo
Message-Id: <20070504133957.1955b1db.sfr@canb.auug.org.au>
In-Reply-To: <20070504031611.GB5567@lixom.net>
References: <20070427084118.GA8842@lixom.net>
	<20070430035339.GA15771@lixom.net>
	<20070504031611.GB5567@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__4_May_2007_13_39_57_+1000_q1zbmJEcmBEGng/3"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__4_May_2007_13_39_57_+1000_q1zbmJEcmBEGng/3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 3 May 2007 22:16:12 -0500 olof@lixom.net (Olof Johansson) wrote:
>
> +	/* ppc_proc_freq is in MHz */
                               ^^^
Actually Hz :-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__4_May_2007_13_39_57_+1000_q1zbmJEcmBEGng/3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGOqsfFdBgD/zoJvwRAnYRAKCHAxqRUrJ55XLiqsc3MK1Ghg+HjQCfXuCq
xkLc110EqW9zT53OTrDAVPs=
=B2rY
-----END PGP SIGNATURE-----

--Signature=_Fri__4_May_2007_13_39_57_+1000_q1zbmJEcmBEGng/3--
