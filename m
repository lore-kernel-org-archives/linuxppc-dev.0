Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F4C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 18:18:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BE2206B6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 18:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BE2206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43d4bR5WFHzDqSr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 05:18:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.21; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43d4Ys0m9BzDqRw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 05:16:48 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK4fR-1gjZmu0ABp-001UC1; Sun, 13
 Jan 2019 19:16:25 +0100
Date: Sun, 13 Jan 2019 19:16:21 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
Message-ID: <20190113181621.GA22334@latitude>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <cover.1547132681.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:GKiCI7OGxiERT7g/JQkZUi3BvJui19xv55rrbrTsdZrmiZdBs55
 LvDwV/XyL4yiX1x3w9T7sVSj+3Exqk5ckzju1NtRjAg2S+ECTgtRtp05qr6egCz7WrUM+YR
 2v3J5UzRz8gk4Mo5PIbusOE27mVKIfqb2rrFy5eI95+WPGesnkJTsWDNXrbvU9te8FGvQI1
 voN69h2So2j5Ugnvm36tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O3BAtFjgAYk=:BAjeosuYluy3Fjj5lozd5Y
 ZGJQxh0gkNhEwnHf1fZH8Iz8EY3tEXrmX1KLxVyoDfiKyj0MPN1WHhD19LHM9UpXF5PYcur7L
 DoXCY/9/reFdAAuHXW0OSNkYqYUzstoiMHG6MenuNQOF+Q13UDCA1kLhWAHmsznVN1Yu+N099
 0d4rQ0xUVf5AGCfbQlrJyCSitr5cHMCs12Wnc1suBcoulSyks5FMr4/ngEvhDTo2ZYn45veGk
 SNM3VrktEzgxSUdGXshpQl33wZ4FPH7CfRHZaoll5xpusp9Cjp7DTkRiNcOIxJYUOafsmTjxE
 1zXpbcudk+0roH/J0xe2HOA5X5p+kCzMpZUfTek0VIUVHAwDQDysd4VcONQlG3hPA5pbdg8Al
 tGLsXicGh7cV2XeaGdjl8Y4e1SSVIARhCuEv/mRJnD12b2OLXCxGPxWjeflOfom52LvSLQeeV
 XwLGpdWCsAzODbugP96+i1BsZiSB2+Ofe8/zflUTGCs7UftB9DyLl487RV/9BSt4TQ/dJUT3g
 KnUk3W0F9lROMDoHOVcAUi8lQnsfd6rm+xR+soN3IdorjcSVcAs4bbAkTmIy7MXnJgHSKucVi
 ooQECZm5gSvhnPUtTEk8lQq8xS9f/GJ+dAbimIwbVEVtEzMSb5Fsl/GKJUqEU2oWnYsmTQAOf
 9nQ3pLy3Fcd2KYobaXg8kNYDOc85zDVUAYYC3+vZh2olk6y14/6MysnJWDHDlckNBIJ1m5TOO
 nO13NHO9tPciwEm6gNsS+uUd+JZhaTbcfLgtWx/OolZS+cPOFi1Y5H4MqTuLufjN64FHWl9Ri
 PIXJYW1Cmq+etLDMI6NSK9yhfnuKWY1XkfxC8zD2DTkQ8u5fGQb+voYlJlK/zMqOZxX0AYe4O
 Ja78kV5OCs+EAPPBUdGtJOQvlsehgYdLxR0n4Mr8I/6qdcpoDRbDZjIHygkPYQ
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
Cc: j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 03:11:38PM +0000, Christophe Leroy wrote:
> The purpose of this serie is to:
> - use BATs with STRICT_KERNEL_RWX on book3s (See patch 12 for details.)
> - use LTLBs with STRICT_KERNEL_RWX on 8xx (See patch 14 for a few details=
=2E)

Hi,

I just tested the whole series on my Wii (I didn't test any intermediate
steps). Without CONFIG_STRICT_KERNEL_RWX, it seems to work fine, but
with it, I get the following error while booting:

> top of MEM2 @ 13F00000
>=20
> zImage starting: loaded at 0x01000000 (sp: 0x0178afa0)
> Allocating 0x166b2c8 bytes for kernel...
> Decompressing (0x00000000 <- 0x01011000:0x01788398)...
> Done! Decompressed 0xf421f4 bytes
>=20
> Linux/PowerPC load: root=3D/dev/mmcblk0p2 rootwait console=3Dusbgecko1
> Finalizing device tree... flat tree at 0x178b7a0
> [    0.000000] printk: bootconsole [udbg0] enabled
> [    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 0x00=
100000 bytes below 0x00000000.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-wii-0003=
8-g335347fa417f #1337
> [    0.000000] Call Trace:
> [    0.000000] [c0f1ff30] [c00280f0] panic+0x144/0x324 (unreliable)
> [    0.000000] [c0f1ff90] [c0c18a34] memblock_alloc_base+0x34/0x44
> [    0.000000] [c0f1ffa0] [c0c071e0] MMU_init_hw+0xcc/0x300
> [    0.000000] [c0f1ffd0] [c0c06554] MMU_init+0x12c/0x198
> [    0.000000] [c0f1fff0] [c0003418] start_here+0x40/0x78
> [    0.000000] Rebooting in 180 seconds..


Jonathan

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlw7gGEACgkQCDBEmo7z
X9sVVQ/7B0BQL0ny6kEQ4OShT740VnQ2CNr2HCjQc3OaveJJtn3/vvB1ooc/o48a
h0ikTC2+uD88s8yErCK0J8qSU/4Oe4S3w6LA7sBQXBsZi4viYUcoB0ypzWAY/MfY
wuzlbKxUxl7tQRlnHFVp1pxk7Uve0Z94q0XVTM/Vq9oUEKZYa+5Bus7dsgs1aHKQ
rA80EP9Uj5iPB6QCP3wrynvxc4rfZb2vZJFKGQ6dn2A4bi8Cnz/hfPNQRaNLtuyS
yjmvy0xYc6s59Um7NTMkKYxG2sR87lt5Ugkma3eOVk47W1nYmg/Whg2/qMZ3sES6
epo8ygw1Ec2zOumLrKZzDMt3cKeeDL/EAgSIJb8Go57KvZP0iav8/qEJ4PJAXhqi
X1AJeStpZVUK/DaTXCecfzj25Ct+R3dJIRDjPrZUbE43Oh2KvV965sXopFPdy1MK
47QodYciVPId6cQ7MSHRpdum38vRU1w7SH3Oz0S02+t4FdAbT3YLiZxqnH80QPrf
7BXizhM202aRctcg8fiQCZV//AiLtvoxVhCrrweY7Y6eb1AQjB35/Zg5kY/3v53k
YhkbPLLqzi5P9PcTJHesjEVlCxk0E0aLh6yOBoETMujRk6Jq55YYgei3EdU/5KEW
Mvd+ozhX62e+7RbePfsByi1fb+qJ7L8UZzGHZKpdUpCtCAzRswc=
=EeTK
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
