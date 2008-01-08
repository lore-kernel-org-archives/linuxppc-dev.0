Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1EABEDDF1B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:49:00 +1100 (EST)
Date: Tue, 8 Jan 2008 11:48:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] Add of_find_matching_node() helper function
Message-Id: <20080108114849.847db508.sfr@canb.auug.org.au>
In-Reply-To: <20080107181418.11906.13427.stgit@trillian.secretlab.ca>
References: <20080107181418.11906.13427.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_11_48_49_+1100_DlLEYjL5rEsF1L4B"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_11_48_49_+1100_DlLEYjL5rEsF1L4B
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Mon, 07 Jan 2008 11:15:56 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +++ b/include/linux/of.h
> @@ -60,5 +66,7 @@ extern const void *of_get_property(const struct device_=
node *node,
>  				int *lenp);
>  extern int of_n_addr_cells(struct device_node *np);
>  extern int of_n_size_cells(struct device_node *np);
> +extern const struct of_device_id *of_match_node(
> +	const struct of_device_id *matches, const struct device_node *node);
> =20
>  #endif /* _LINUX_OF_H */
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 212bffb..6dc1195 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -10,8 +10,6 @@
> =20
>  #define	to_of_device(d) container_of(d, struct of_device, dev)
> =20
> -extern const struct of_device_id *of_match_node(
> -	const struct of_device_id *matches, const struct device_node *node);
>  extern const struct of_device_id *of_match_device(
>  	const struct of_device_id *matches, const struct of_device *dev);

So you should really change all the callers of of_match_node to include lin=
ux/of.h.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_11_48_49_+1100_DlLEYjL5rEsF1L4B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgsh1TgG2atn1QN8RArJIAJ96weIRkx8YcvmrNDAusiSsgtsmmwCfRV2H
HlPELl3rvSz1h9JKo3MxI/w=
=qyCk
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_11_48_49_+1100_DlLEYjL5rEsF1L4B--
