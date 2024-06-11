Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33406C25B76
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2024 10:38:04 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bf4D/jow;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vz4rV0xN0z3c4h
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2024 20:38:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bf4D/jow;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vz4qj1r71z30TZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2024 20:37:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A0222CE1379;
	Tue, 11 Jun 2024 10:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E442C2BD10;
	Tue, 11 Jun 2024 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718102238;
	bh=nds2TJge5Z4TpoZDLAtUnD28Qvbmk5QsBVyZINMe6lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bf4D/jow1a8Ng/Hil+lAqb0dut/RYwZPvQ3FPZbbkJ7aCG3CveDoJ8iAXzFOI8uEE
	 9yDRNNq0FPsUcFhikkmpU/E5w5feE7DXdPkDNYG9myT/DRd/Z6y6hSguT5PToyK+P4
	 YsIIdY5FwPBIolZReklyVMjMCN/HQe/fKvVJxqsGGDNknEFWJJjyxvCBI+N+Hz4b6L
	 ejwQ53ezYu29at7MPLf3bzifn7TzIPlM2VP2jVzLwlOwrQJjfdnhIyJ+1XBCzpDGqb
	 Yo4pdYTi13dJlDfvejmLRB2pxjXOTtTR2aWrT0nfBqElFPYYSgETvleS1E7ztkPUUV
	 wvZ1spKxyGKaA==
Date: Tue, 11 Jun 2024 11:37:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Subject: Re: [Patch v2 2/2] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT
 binding
Message-ID: <Zmgo239qK_hi5Z8B@finisterre.sirena.org.uk>
References: <[PATCH]ASoC:fsl:Addi2sandpcmdriversforLPC32xxCPUs>
 <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmKDFPdi4BGueWVw"
Content-Disposition: inline
In-Reply-To: <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com>
X-Cookie: Your love life will be... interesting.
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Chancel Liu <chancel.liu@nxp.com>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--pmKDFPdi4BGueWVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 11:47:52AM +0200, Piotr Wojtaszczyk wrote:

> Changes for v2:
> - Added maintainers field
> - Dropped clock-names
> - Dropped unused unneded interrupts field


> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

Some of the dropping of clock-names was missed.

--pmKDFPdi4BGueWVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoKNoACgkQJNaLcl1U
h9Bg/wf9FyJJF7rPVkdR+i37hUYzzoNUoE7vaCl2WvvG5hjhTL5MdU6XdKMBsAM1
pN4nQeJ7X+zozGaPqwucwfbyg0MN+0LVOvhugSIVGSCY2hDKEDlQoGaPvj5wZVOo
4baY5NtBKZX6UfdsEp/JhNf9sA7thdZKXKAqt0v78ncgpyF+0Xlbu5key3Z47c4W
fPQGPexS6kgG7+x3DPn6b3SKVBdeRDOajyFXzabE0Kg/0zEIo9ns5ycI4/lzby0A
IF+GEw4DfF8RyPnPrGjsxl2F3GS4+qJHRAwk5zFbIEPC9WILwwJ8TgkfxqmlU7bb
E1TX4jDGVqFB09TRVdAjbycxlkBL0A==
=UIHv
-----END PGP SIGNATURE-----

--pmKDFPdi4BGueWVw--
