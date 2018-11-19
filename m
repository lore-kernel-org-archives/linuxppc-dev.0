Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02914C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 00:35:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4A72080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 00:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aSEJ+216"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4A72080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yqcD2b5RzF3T3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 11:35:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aSEJ+216";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yqPK6nnyzF3Rp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 11:25:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="aSEJ+216"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42yqPK2DLmz9sCV; Mon, 19 Nov 2018 11:25:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542587141;
 bh=97jYdCPpKarifkA3lZpBdLyMQeJM3hq/No/1JXghZM8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aSEJ+216C4EJkdNFgJI+EDPC1JNnp6g65HvLeWHOEyDXOL4Njfg/Srm3/gfp9230u
 ZUWDdOk+WLE0+a0mwF6Dg6mH+hjmURsIHA2xdnTPTD6xzqIdTZlX5OZtRo688z6wbs
 fDeshgSwuxFVV5+kNH282v+Zxi9TU7hLdD09oD54=
Date: Mon, 19 Nov 2018 11:21:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 16/22] powerpc/powernv: Add purge cache OPAL call
Message-ID: <20181119002113.GC4878@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-17-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-17-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:17PM +1100, Alexey Kardashevskiy wrote:
> Flushing caches using the dcbf instruction takes quite some time if we
> need to flush gigabytes (16GB takes more than 15s); OPAL just added
> a big hammer to flush all caches.
>=20
> This adds opal_purge_cache() which will be used later to flush caches
> for coherent GPU memory which might suddenly become unavailable if a GPU
> is reset and NVLink is not (re)trained.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/opal-api.h            | 3 ++-
>  arch/powerpc/include/asm/opal.h                | 1 +
>  arch/powerpc/platforms/powernv/opal.c          | 1 +
>  arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
>  4 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/a=
sm/opal-api.h
> index 870fb7b..55bc640 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -210,7 +210,8 @@
>  #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
>  #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
>  #define	OPAL_NX_COPROC_INIT			167
> -#define OPAL_LAST				167
> +#define OPAL_CLEAR_CACHE			170
> +#define OPAL_LAST				170
> =20
>  #define QUIESCE_HOLD			1 /* Spin all calls at entry */
>  #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/o=
pal.h
> index ff38664..7db576e 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -294,6 +294,7 @@ int opal_set_power_shift_ratio(u32 handle, int token,=
 u32 psr);
>  int opal_sensor_group_clear(u32 group_hndl, int token);
>  int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
>  int opal_nx_coproc_init(uint32_t chip_id, uint32_t ct);
> +int opal_purge_cache(void);
> =20
>  s64 opal_signal_system_reset(s32 cpu);
>  s64 opal_quiesce(u64 shutdown_type, s32 cpu);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platfor=
ms/powernv/opal.c
> index beed86f..44ce824 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -1113,3 +1113,4 @@ EXPORT_SYMBOL_GPL(opal_int_eoi);
>  EXPORT_SYMBOL_GPL(opal_error_code);
>  /* Export the below symbol for NX compression */
>  EXPORT_SYMBOL(opal_nx_coproc_init);
> +EXPORT_SYMBOL(opal_purge_cache);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerp=
c/platforms/powernv/opal-wrappers.S
> index 2515282..5b886a6 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -331,3 +331,4 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET=
_PBCQ_TUNNEL_BAR);
>  OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
>  OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
>  OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
> +OPAL_CALL(opal_purge_cache,			OPAL_CLEAR_CACHE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyAfgACgkQbDjKyiDZ
s5JGZg/+I2F64TgVda71Evd2ZDPZMaBxxffWDhZXN1pV3n4kmMlFHT65nqGB3RME
cl1MLskbSOi2OcitHbXtJjkUfNj/Mc65SVWCNMd71IIWI7kON5kTkIAWdLfxdpag
Sen1ZV5RUUx9y04hX4hP9kIANQKBMG98PCeAnMXMIm8Y2plOE5uPgCGzewx37SfM
mXFV7c+fy3IogNR26M/D58D6o4AKIL1K6DGM+gkwBSNDyaJgSmofqbDLRfoyHc7v
+PO1w1Af0S/Yi1sqDZ6iYQwm710rOA60/jZMeD8nIbrG3Sgz40bKmrsrXJpcTmI4
74phoOASayUEBivbExqakTfXJRMc2vvajtSCPrmccqGnyQ2kC6H6suQovkfUbxCA
boPiXyW3gKwlBAjG5PNn138IIvfAmZaX5HV2D28J954kZtuI9CfoFbBzviWsfSMt
sxZ8dqM2ObFx375nAsN61HpptWFhuKDcR+3ehptFArqAkX3KJ9dEcCz+qQiSci5E
hzV7SLY51lJIGOAxBv2Zqp2QDa19rXkOv/ikHIJ2J8Fm7S7QZ/vmkYZuvP/PhdCB
ELfNOowWmeGDljNbIbGg6ry+rLS5IGzK2gLHKdySLMVBRm4EXce35BHsNiCFiYK6
6zX1JA8jVff8C1hFgW1B/Lacshns0YarDizt5xtirQqjLD8GSeg=
=/o+n
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
