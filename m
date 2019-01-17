Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BCCC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 01:07:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F74320651
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 01:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F74320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43g5Wt6w1RzDqkZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:07:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.22; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43g5V62jD4zDqhR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 12:05:33 +1100 (AEDT)
Received: from longitude ([89.0.34.110]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGip3-1gWTrl3vcn-00DXJN; Thu, 17
 Jan 2019 02:05:13 +0100
Date: Thu, 17 Jan 2019 02:05:09 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RESENDING PATCH] powerpc/wii: properly disable use of BATs when
 requested.
Message-ID: <20190117010509.GH22334@latitude>
References: <7e6748349978f4f177b6a1f3f1c773da98ae3b59.1547570012.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <7e6748349978f4f177b6a1f3f1c773da98ae3b59.1547570012.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:cyDBWVVTRYaWOVmOOSJGQacNT7qwshP67Nxe35TZwkmTif0ZNcL
 QFhi0wAsBvVhRoUGqC8NNmAcOu3XrMpfCA11FE+1dKLM1yJ1uqPW6GsQtldMwY1SRsUsGuh
 etWZCbPM3NuOHm21C3mXKZSRTktQ4RcfixZaE0DBewfJ3BlpzoRnuQMnA5Vo8tBFjCNg5u1
 lGebbvKuhzM6nil+8m80g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y/2qgP2U+VI=:BWhNPri8+81V93gRdMD2gY
 1tAexu19Q3U0WDM5j73OQ6JwxF7oQH6GueVyBPClj3ETDWZ1+oNdiIkdsluApR9zTSirI1+0H
 i5/wag5I0VE6gQ7PM3BSIln6kJxfQdmmB2HJmzLy/xUeQY3rYiqWY/SvW2j1FCBQZ/i4wp8GF
 DGxMD1naIy9gBaPCUs0bflar0KE7cAOEXMgA/y6yWEwaKpa3VfLb8RiYLZRRlmzw8YqFQtC3d
 mvnu5BEHlYCGcX7dXgbJnnz1XqJQ4Ej8p4TxruqBUbDaJI0g5DGzkjNmEXtRGuNnnax7euEEy
 JtSErsS0OoXnlL/EtyhkMJjNnRbgttBdzE+EGw1Ht+AYT6EDMgbKz0QFfthY2cBQ+hM9h3vzX
 XjgJeZVpWqDqBaK8ZN43WDCHrVQxWVaEcTrNRHRvFNQVjAKZOzXinQP74kD5kXRO4rpz6QRIf
 Ec0odd3Wqbczu2qm3lDgCHeTjpsCm0JjEAGzyauRyTorPCYXXOMJwpHsxWV/zQVZ3QTRBScdC
 zHil6CtJRbSwNd1MvFzF04JWQFaMCgMkPmrDO+YXRsRHPbuC3f7abEQ8kw05jgPg0OGaPX3Kl
 HwAlgyL8hVpJ/h6idDEOTcOMC90eSrexL2zWILEMrImJhvjMa8WxDyfqzFAK0I8NGBjrVmSFf
 zU4iMydfxuPtX4ajXSAimHFnQ7INnOiqSmqZutTnzbMkHNKTueBJNdLIcF89o2AtEIfyUVhvd
 Nve15naglFeB3VWUBpJZImhuNVFl8EyAW1Ng53SD3jRS8LqdzmHPZCI9zTDm4xvQgnswvSguW
 4620Etq7OGmLTVcedyFOOLNzTbJRX0WXSmgcc0FGowTFzIb64P+DQmFRQY9WYW61ST+kCq6nT
 +2/zRb18hAURc3qmI631LbreOTRx2HQWarY7/pzrSl97YEJQ+gmz/lquoDpzw3
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
Cc: Jonathan Neuschafer <j.neuschaefer@gmx.net>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

On Tue, Jan 15, 2019 at 04:43:20PM +0000, Christophe Leroy wrote:
> 'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
> deny the use of BATS for mapping memory.
>=20
> This patch makes sure that the specific wii RAM mapping function
> takes it into account as well.
>=20
> Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
[...]
>  	/* MEM2 64MB@0x10000000 */
>  	delta =3D wii_hole_start + wii_hole_size;
> +	if (__map_without_bats)
> +		return delta;
> +

Nothing is visibly broken without this patch, even with
CONFIG_DEBUG_PAGEALLOC (tested on top of v5.0-rc2), but the patch still
looks correct.

I'd prefer the 'if' block to be before the whole delta/size calculation,
to make the code slightly more readable because the delta and size
calculations stay in one visual block. It doesn't need to happen after
delta is calculated.

tentatively,
Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


Thanks,
Jonathan

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlw/1LwACgkQCDBEmo7z
X9t15w/9HAIpyLsvt8vSwK4gfTd5obM3aiOswCoMWl5NJty0FA0ptb8htS29OHfe
vvJ99HXuAh7Mg+2wtXIwqNZs7lk1EVT6N80ORj4LP7xQCzxR1q6BWaWPmSDjTtQw
aeub/Px9Ldb7Ynglqys4fnsEi9MWUVYa++WvZ5s8UOMk6wRfxOIItUvSnOwVgATG
KvXc7t1OJsJbgU+Goay6HggyQNmk4G9asv+OtD+hVazDpHiEOeQYweGLlQ2/lgjI
MaEZ7FRZLqqBjTviCXkLLUJ5wkR9+Q6wioDU9ss1eHczuZinfUDoY5LYnj3oqOwn
vLiC+HbaV2yniS6CHRLXEyonnBzVX0MHTjSiQRmfZBbX2rAaXrQbV/JUztswA/3A
KcDERzAr2R1ZUgp8aNELQQJC5n3BhCutXJ/CndsDkqrQq5FJOEpfmuUmoJYvf+1q
vkrLmezvcrlcgPn2H4iDi/986BAGvJNdPq0cN8x2qusn1Onb1JM7HeyNC06JR3BM
ILCTpmpDm2lKkEL0lbFSACeIvFcuQk2A/778w/RT9Z3WN4NONthnObD79h2RFNQu
1XmWMLgIyjTrOl5zDITwa6LsleEkDeIQo7h+3qdbytDXQAMHQhsz8nJNDh6kL6kT
o8lhk28kHVMQGiGtp1M8VJBdW1KctUKwBOuprSAtJts9x8YPiYE=
=ftf9
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
