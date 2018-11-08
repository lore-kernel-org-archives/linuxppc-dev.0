Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F548C32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 12:07:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96AA2086C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 12:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z0O1JeYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96AA2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rMVL1wWDzF3HL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 23:07:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z0O1JeYi";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rMQV45VnzF1RB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 23:04:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Z0O1JeYi"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42rMQT58Dwz9sBZ; Thu,  8 Nov 2018 23:04:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541678657;
 bh=d8oHpwuvhZOLM4oHoJ46eeJ8JZhHTDitG3HrGWRnBMI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z0O1JeYioq3l9a+ds0lPrnu6cj/3gP4KYzj9iMwXKWxVUw++XeXfG6hk6lR6Y/toG
 /uQznaFiJyezq0o5r55ga9FZDxX6zmI30s4MqQ93NW9KTjLL5KA8ZIwUGgJPW9W0r/
 M1qOhWHVu5PkAm3gI7yaDSSMzLC4WOZDDryKH36s=
Date: Thu, 8 Nov 2018 18:16:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 2/3] vfio_pci: Allow regions to add own capabilities
Message-ID: <20181108071623.GA26872@umbus.fritz.box>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-3-aik@ozlabs.ru>
 <20181108062139.GQ5575@umbus.fritz.box>
 <72022e34-6cf0-3946-8049-ba3d998097f3@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <72022e34-6cf0-3946-8049-ba3d998097f3@ozlabs.ru>
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
Cc: kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 05:48:58PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 08/11/2018 17:21, David Gibson wrote:
> > On Mon, Oct 15, 2018 at 08:42:32PM +1100, Alexey Kardashevskiy wrote:
> >> VFIO regions already support region capabilities with a limited set of
> >> fields. However the subdriver might have to report to the userspace
> >> additional bits.
> >>
> >> This adds an add_capability() hook to vfio_pci_regops.
> >>
> >> This is aiming Witherspoon POWER9 machines which have multiple
> >> interconnected NVIDIA V100 GPUs with coherent RAM; each GPU's RAM
> >> is mapped to a system bus and to each of GPU internal system bus and
> >> the GPUs use this for DMA routing as DMA trafic can go via any
> >> of many NVLink2 (GPU-GPU or GPU-CPU) or even stay local within a
> >> GPU.
> >=20
> > This description doesn't really make clear how per-region capabilities
> > are relevant to these devices.
>=20
>=20
> I am confused. This patch just adds a hook, and the device specifics are
> explained in the next patch where they are used...

Well, my point is the last paragraph of the commit message appears to
be a rationale for this change in terms of what's needed for the GPU
devices.  But how those described properties of the GPU mean that
region capabilites are useful / necessary isn't made clear.  If it's
not meant to be a rationale, I'm not sure what it's doing there at
all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvj4sQACgkQbDjKyiDZ
s5Ih1xAA0Lr5Tj0mBKT85tbpp4uub6lvh5gJy2J+/juXrz1c2DLuSgW2ZNGWqSUN
CxxWHepsSITw3xfAgs7RcBgWetsF372MLQAunAYPVRW0zzXQFBfmANKVfiUCJ9zm
E7KkfprxMWFU9a4LoNe0q7Nd9U4GMGTskDD3GtnQ3o3W6iGUslyHA3nWg4t0Ggvj
DCpTn9cBAmNg3dZYr11TeqmPetKeTf4IPjnubAYL7gCk/cEub1vUXxz/ZDyTFgPG
PnWlELGh/KoU18+q03UYJF9pf62Gv08f8PxTzlA30b+hg8JdAC0xSSl8HOnvR2mo
FLakDfeblPMk6AEbonk0oE95HQfxDHY7DyWaauGDxr3IJwVv5lQ/g9/JEO4sx1Sc
mUCpH5SXwOOBPplhyertdRABXcGJYt3G9TfJuMGxdD2eK6qPOSPcninQfcaEwZfF
1yGot1TxaMvft6LUuyBJhfD7zVymWyVnRSgfSxAdhHSdArQyTFGREckbczRfr82z
tXKf7DL1wQmtfjbxQb2L7Ijkvp8cWqiBgaxkR7s2qO3JmFSv40S4BpDCUVOy8hKm
15AL5eqVxa0vsevow2FAeJ3XeprS7fWNpXMhC7N3Z6Ea3GuIedbXdgKGlLogBqlX
2t8Q9AoAsaoSZtCjtzEQ1XI8PCYvvXQ1mDvo2SAo59glnFSVcU8=
=Uten
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
