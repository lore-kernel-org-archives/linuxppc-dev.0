Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 113F1DDE43
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 13:23:09 +1100 (EST)
Date: Wed, 21 Mar 2007 13:23:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Subject: Re: [patch 05/10] Use KERN_EMERG everywhere in oops printout
Message-Id: <20070321132306.b0d24a69.sfr@canb.auug.org.au>
In-Reply-To: <20070321013825.179096000@samba.org>
References: <20070321013810.404636000@samba.org>
	<20070321013825.179096000@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__21_Mar_2007_13_23_06_+1100_MhVTI7+gvqXbk9Cy"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__21_Mar_2007_13_23_06_+1100_MhVTI7+gvqXbk9Cy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 20 Mar 2007 20:38:15 -0500 anton@samba.org wrote:
>
> -			printk("\n");
> +			printk("\n%s", KERN_EMERG);

Why not
			printk("\n" KERN_EMERG);

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Mar_2007_13_23_06_+1100_MhVTI7+gvqXbk9Cy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGAJcXFdBgD/zoJvwRAvPPAJ9Q4RUaz491NI0ivcehDxFKNRUJ3gCfR8mf
vXZ0tMPq3IfWfP+MgYi98Xs=
=vfaF
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Mar_2007_13_23_06_+1100_MhVTI7+gvqXbk9Cy--
