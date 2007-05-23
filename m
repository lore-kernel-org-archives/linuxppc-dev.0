Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B4F3DDDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 09:42:38 +1000 (EST)
Date: Thu, 24 May 2007 09:42:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 1/4] powerpc: Add EEH sysfs blinkenlights
Message-Id: <20070524094232.317bd4de.sfr@canb.auug.org.au>
In-Reply-To: <20070523171646.GA32380@austin.ibm.com>
References: <20070523171328.GY5921@austin.ibm.com>
	<20070523171646.GA32380@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__24_May_2007_09_42_32_+1000_=ukRgYQauBaguLiw"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__24_May_2007_09_42_32_+1000_=ukRgYQauBaguLiw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Linas,

On Wed, 23 May 2007 12:16:46 -0500 linas@austin.ibm.com (Linas Vepstas) wrote:
>
>
> +	if (rc)
> +		printk(KERN_WARNING "EEH: Unable to create sysfs entries\n");

Maybe use dev_warn?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_May_2007_09_42_32_+1000_=ukRgYQauBaguLiw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGVNFtFdBgD/zoJvwRAnz8AJ9Ncf9G8p734/5XfgJlnO9Idn31NgCeO/Bx
wnWHD7Jxw9yDlBLvGxVR8VQ=
=P8SZ
-----END PGP SIGNATURE-----

--Signature=_Thu__24_May_2007_09_42_32_+1000_=ukRgYQauBaguLiw--
