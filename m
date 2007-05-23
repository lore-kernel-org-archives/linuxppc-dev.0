Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1036DDDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 09:53:36 +1000 (EST)
Date: Thu, 24 May 2007 09:53:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 3/4] powerpc: remove dead EEH code.
Message-Id: <20070524095327.75e239b2.sfr@canb.auug.org.au>
In-Reply-To: <20070523172338.GC32380@austin.ibm.com>
References: <20070523171328.GY5921@austin.ibm.com>
	<20070523172338.GC32380@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__24_May_2007_09_53_27_+1000_B8MIJ+RZhuI80pQd"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__24_May_2007_09_53_27_+1000_B8MIJ+RZhuI80pQd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 23 May 2007 12:23:38 -0500 linas@austin.ibm.com (Linas Vepstas) wrote:
>
> @@ -1221,11 +1220,10 @@ static int proc_eeh_show(struct seq_file
>  				"check not wanted=%ld\n"
>  				"eeh_total_mmio_ffs=%ld\n"
>  				"eeh_false_positives=%ld\n"
> -				"eeh_ignored_failures=%ld\n"
>  				"eeh_slot_resets=%ld\n",
>  				no_device, no_dn, no_cfg_addr,
>  				ignored_check, total_mmio_ffs,
> -				false_positives, ignored_failures,
> +				false_positives,
>  				slot_resets);

This changes a user visible interface - are we sure noone uses it?
(I suspect it is fine because of the format, but just asking anyway.)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_May_2007_09_53_27_+1000_B8MIJ+RZhuI80pQd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGVNQAFdBgD/zoJvwRAoQGAJ4s40fw5BVOsY3EtFsXASRSBQvYlwCcDoYx
kW4pl3MAPMk+cDR2sjrj8/Q=
=m8AJ
-----END PGP SIGNATURE-----

--Signature=_Thu__24_May_2007_09_53_27_+1000_B8MIJ+RZhuI80pQd--
