Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EA97C2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 05:59:59 +1100 (EST)
Date: Wed, 18 Dec 2013 18:59:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20131218185952.GM31886@sirena.org.uk>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="37nyS7qXrnu4wN2o"
In-Reply-To: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode support for
 SSI on i.MX series
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 timur@tabi.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--37nyS7qXrnu4wN2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2013 at 06:44:45PM +0800, Nicolin Chen wrote:

> +/**
> + * fsl_ssi_set_dai_tdm_slot - set TDM slot number
> + *
> + * Note: This function can be only called when using SSI as DAI master
> + */
> +static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
> +				u32 rx_mask, int slots, int slot_width)
> +{
> +	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> +	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> +	u32 val;

I'm a bit concernred about what this is for and why it's required - is
it something that machine drivers have to call and if it is shouldn't
the driver be defaulting to a sensible configuration?

--37nyS7qXrnu4wN2o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsfClAAoJELSic+t+oim9fmYQAIVcUuSYb9weiJKugFkgjdc1
mqC7Hi3rTk0XMFWgz8Z7O7Q496xgGA7sCyfio85/N7m7/s/aMN0LNSH9e8OG/LKl
jQGJ1owKUL7WW9i85DLZEanViki+IcPyNpQCwiPHz9G+6eEtq5MxAGVSRGmA33tb
dHRX+La2yNdGlhUDYMKhJYHB+1rH1idTZ16H/LFNSqSh8JSWTMlcdLX8yyRYaVqM
NDqQpn6iP5XpZPurgzccPXjQ7cVPjvwInZo2HYQZM1WGpSP1ANg7QmdnzG/HBRmE
I+KRznTVzj2Qj3u5/xDzmP5TlnDcLTtlIjlDlA+2BS1QPeL01Kwz9hgQEhGQ3aKP
dqdSnK6/hMBM0NSf5uKS0Sbi8mr5TMUOyxwCYhgqE9eICKIzp3muTEZM7rm2xYs9
L4w+HRgNe18OuYPF3WC6C7FPRMLx4yfsgKoArX2fncik9lgcakMgxCe9QpIZDmts
rBgHCbfI70S4EAOu2T/A28dKybLVVZAp3a9OUxd2xyWItriRCeM3+RU3RbxxrVyU
iKeZW6GoCLQbzEv5EY+cd4oinbHfOJgiQ07WgbnekKPW80tn+TbJxXVcYMJGyrEk
iehvp6LqdEavhIa9vZAmkPMTlaw+yxz2/rNDbQAXZ1w8QYfhQ/Kf0IJk8W2LwUrP
Ls+8wfpxMGapqQHFZSgx
=morP
-----END PGP SIGNATURE-----

--37nyS7qXrnu4wN2o--
