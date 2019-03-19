Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFBDC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 05:39:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E88720854
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 05:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gXImIa4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E88720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Nhh00kVrzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 16:39:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nhf32m8KzDqHd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 16:37:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="gXImIa4b"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44Nhf21qdLz9s70; Tue, 19 Mar 2019 16:37:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552973866;
 bh=GmXSunq4Itnlv5S8obGRBKoOTVTYSxyTQwYv+Gou/Rg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gXImIa4bOvDH40OSHpRi2f7LlbZZlMWcFk4WLNgIV7bFPV4MJh3pK91tV1oyfYsDR
 SXZnleas9/7Xy00C150diFVsuk4AuY5PhI8a+hAktsqosNnXIjepLq54iWluEvJRg1
 GxD7BUdXCqfGymDCMYYafQZt9ZOe1NDwrhIaTWrk=
Date: Tue, 19 Mar 2019 16:08:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 10/17] KVM: PPC: Book3S HV: XIVE: add get/set
 accessors for the VP XIVE state
Message-ID: <20190319050821.GC31018@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-11-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:06:02PM +0100, C=E9dric Le Goater wrote:
> The state of the thread interrupt management registers needs to be
> collected for migration. These registers are cached under the
> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
> pulled from the HW thread. An OPAL call retrieves the backup of the
> IPB register in the underlying XIVE NVT structure and merges it in the
> KVM state.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

[snip]
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index e6a984592189..eb864d72ddc3 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -104,6 +104,25 @@ the legacy interrupt mode, referred as XICS (POWER7/=
8).
>      -ENOENT: Unknown source number
>      -EINVAL: Not initialized source number
> =20
> +* VCPU state
> +
> +  The XIVE IC maintains VP interrupt state in an internal structure
> +  called the NVT. When a VP is not dispatched on a HW processor
> +  thread, this structure can be updated by HW if the VP is the target
> +  of an event notification.
> +
> +  It is important for migration to capture the cached IPB from the NVT
> +  as it synthesizes the priorities of the pending interrupts. We
> +  capture a bit more to report debug information.
> +
> +  KVM_REG_PPC_VP_STATE (4 * 64bits)
> +  bits:     |  63  ....  32  |  31  ....  0  |
> +  values:   |   TIMA word0   |   TIMA word1  |
> +  bits:     | 127       ..........       64  |
> +  values:   |            unused              |
> +  bits:     | 255       ..........      128  |
> +  values:   |            unused              |
> +
>  * Migration:
> =20
>    Saving the state of a VM using the XIVE native exploitation mode

Nit: looks like this doc needs to be updated now that only 2x 64-bit
values are returned.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyQeUMACgkQbDjKyiDZ
s5IPnQ//Yw6FUlp92I+KVwVQGNHQt7mtHGrQUbkp8mcU6fn9v5iXp8YWWrooyh7g
Bt46WJb/uDDuG3y5myNLURC/PPzhQ6LxZ6KZKsQOWIOg73dc6dDwwaedikHYr092
wLMg3lix5fEuxkFhC17zo5n2P/K1ciwUsrhL7KjqsoS4V7pcrS2fukZ017+jMAU+
6mGGGT3diN84hWsz/OwfgUQSyJuxVzjz2Y0OB0by6mjlrgq+x+7WVEtyJYVDHWTx
Ayeu6szg6CqaDSZj0QRUQ5bOGLM9/64MqmePFPX3ZQRZA2jdBVUGPoEqeg3y0xeI
6a5pmnD8j0xZLpsdiuv3hq+FuuKuFFHGtqO8MAMa80UAetRrD24kUcpWjin2p6WY
mEQgDmmwFPVzVuXeVqH/InaETlGrL+qzjsd1OjT64L153uRNtVP/M8ZVnIbG3yqV
Tn5XDXgGV4FIbd1kD5b2Ivhy3O+Dn/LdCwB8ptc8xK4WIpY9REgr6A3Y7H3naUZ3
GlDjJElY98Kkn3bN6Ae2YEd7G4xIhDMNzNp53rjPgHVU3t9FT3wAkns5e3ZRr4N3
bWYpeaeKnw/TWKJkFgwwI9oZRwzxwqE9rD/wyutfY3FAjPMSLhNi56Ie5h5qyHQe
KOmwhXTldaLaDUJWbQijtqrA1jxIEGd82Ph/YclmVex3xT2s/20=
=u344
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
