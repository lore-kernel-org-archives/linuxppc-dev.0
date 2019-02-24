Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:05:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E1D2084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k09jPs11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E1D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477dH6pWczDq7w
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:05:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rk3LyKzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="k09jPs11"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rk1wWsz9sCH; Mon, 25 Feb 2019 14:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067010;
 bh=L7UtPKcpKXf94nPw2kurjtIUKKpPCWd2NTwGpKIYkbU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k09jPs11yoBrpTpLBaFThSaU38Xk0ginAUok4czgFPY8MfAmrtCGrcX9n1xjKykT0
 88r4HHBive+G46bk14wIihAdR1Rig85HpIOa8grQInowvo9alfsgK/Xhg7gXc9m970
 DJ3sNZB4um1VNizHsxxFNF5pjmdor1RpXEs8Sz+s=
Date: Mon, 25 Feb 2019 10:42:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 01/16] powerpc/xive: add OPAL extensions for the XIVE
 native exploitation support
Message-ID: <20190224234235.GE7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-2-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:25PM +0100, C=E9dric Le Goater wrote:
> The support for XIVE native exploitation mode in Linux/KVM needs a
> couple more OPAL calls to configure the sPAPR guest and to get/set the
> state of the XIVE internal structures.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/opal-api.h           | 11 ++-
>  arch/powerpc/include/asm/opal.h               |  7 ++
>  arch/powerpc/include/asm/xive.h               | 14 +++
>  arch/powerpc/sysdev/xive/native.c             | 99 +++++++++++++++++++
>  .../powerpc/platforms/powernv/opal-wrappers.S |  3 +
>  5 files changed, 130 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/a=
sm/opal-api.h
> index 870fb7b239ea..cdfc54f78101 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -186,8 +186,8 @@
>  #define OPAL_XIVE_FREE_IRQ			140
>  #define OPAL_XIVE_SYNC				141
>  #define OPAL_XIVE_DUMP				142
> -#define OPAL_XIVE_RESERVED3			143
> -#define OPAL_XIVE_RESERVED4			144
> +#define OPAL_XIVE_GET_QUEUE_STATE		143
> +#define OPAL_XIVE_SET_QUEUE_STATE		144
>  #define OPAL_SIGNAL_SYSTEM_RESET		145
>  #define OPAL_NPU_INIT_CONTEXT			146
>  #define OPAL_NPU_DESTROY_CONTEXT		147
> @@ -209,8 +209,11 @@
>  #define OPAL_SENSOR_GROUP_ENABLE		163
>  #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
>  #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
> -#define	OPAL_NX_COPROC_INIT			167
> -#define OPAL_LAST				167
> +#define OPAL_HANDLE_HMI2			166
> +#define OPAL_NX_COPROC_INIT			167
> +#define OPAL_NPU_SET_RELAXED_ORDER		168
> +#define OPAL_NPU_GET_RELAXED_ORDER		169
> +#define OPAL_XIVE_GET_VP_STATE			170
> =20
>  #define QUIESCE_HOLD			1 /* Spin all calls at entry */
>  #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/o=
pal.h
> index a55b01c90bb1..4e978d4dea5c 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -279,6 +279,13 @@ int64_t opal_xive_allocate_irq(uint32_t chip_id);
>  int64_t opal_xive_free_irq(uint32_t girq);
>  int64_t opal_xive_sync(uint32_t type, uint32_t id);
>  int64_t opal_xive_dump(uint32_t type, uint32_t id);
> +int64_t opal_xive_get_queue_state(uint64_t vp, uint32_t prio,
> +				  __be32 *out_qtoggle,
> +				  __be32 *out_qindex);
> +int64_t opal_xive_set_queue_state(uint64_t vp, uint32_t prio,
> +				  uint32_t qtoggle,
> +				  uint32_t qindex);
> +int64_t opal_xive_get_vp_state(uint64_t vp, __be64 *out_w01);
>  int64_t opal_pci_set_p2p(uint64_t phb_init, uint64_t phb_target,
>  			uint64_t desc, uint16_t pe_number);
> =20
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/x=
ive.h
> index 3c704f5dd3ae..b579a943407b 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -109,12 +109,26 @@ extern int xive_native_configure_queue(u32 vp_id, s=
truct xive_q *q, u8 prio,
>  extern void xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 pr=
io);
> =20
>  extern void xive_native_sync_source(u32 hw_irq);
> +extern void xive_native_sync_queue(u32 hw_irq);
>  extern bool is_xive_irq(struct irq_chip *chip);
>  extern int xive_native_enable_vp(u32 vp_id, bool single_escalation);
>  extern int xive_native_disable_vp(u32 vp_id);
>  extern int xive_native_get_vp_info(u32 vp_id, u32 *out_cam_id, u32 *out_=
chip_id);
>  extern bool xive_native_has_single_escalation(void);
> =20
> +extern int xive_native_get_queue_info(u32 vp_id, uint32_t prio,
> +				      u64 *out_qpage,
> +				      u64 *out_qsize,
> +				      u64 *out_qeoi_page,
> +				      u32 *out_escalate_irq,
> +				      u64 *out_qflags);
> +
> +extern int xive_native_get_queue_state(u32 vp_id, uint32_t prio, u32 *qt=
oggle,
> +				       u32 *qindex);
> +extern int xive_native_set_queue_state(u32 vp_id, uint32_t prio, u32 qto=
ggle,
> +				       u32 qindex);
> +extern int xive_native_get_vp_state(u32 vp_id, u64 *out_state);
> +
>  #else
> =20
>  static inline bool xive_enabled(void) { return false; }
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive=
/native.c
> index 1ca127d052a6..0c037e933e55 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -437,6 +437,12 @@ void xive_native_sync_source(u32 hw_irq)
>  }
>  EXPORT_SYMBOL_GPL(xive_native_sync_source);
> =20
> +void xive_native_sync_queue(u32 hw_irq)
> +{
> +	opal_xive_sync(XIVE_SYNC_QUEUE, hw_irq);
> +}
> +EXPORT_SYMBOL_GPL(xive_native_sync_queue);
> +
>  static const struct xive_ops xive_native_ops =3D {
>  	.populate_irq_data	=3D xive_native_populate_irq_data,
>  	.configure_irq		=3D xive_native_configure_irq,
> @@ -711,3 +717,96 @@ bool xive_native_has_single_escalation(void)
>  	return xive_has_single_esc;
>  }
>  EXPORT_SYMBOL_GPL(xive_native_has_single_escalation);
> +
> +int xive_native_get_queue_info(u32 vp_id, u32 prio,
> +			       u64 *out_qpage,
> +			       u64 *out_qsize,
> +			       u64 *out_qeoi_page,
> +			       u32 *out_escalate_irq,
> +			       u64 *out_qflags)
> +{
> +	__be64 qpage;
> +	__be64 qsize;
> +	__be64 qeoi_page;
> +	__be32 escalate_irq;
> +	__be64 qflags;
> +	s64 rc;
> +
> +	rc =3D opal_xive_get_queue_info(vp_id, prio, &qpage, &qsize,
> +				      &qeoi_page, &escalate_irq, &qflags);
> +	if (rc) {
> +		pr_err("OPAL failed to get queue info for VCPU %d/%d : %lld\n",
> +		       vp_id, prio, rc);
> +		return -EIO;
> +	}
> +
> +	if (out_qpage)
> +		*out_qpage =3D be64_to_cpu(qpage);
> +	if (out_qsize)
> +		*out_qsize =3D be32_to_cpu(qsize);
> +	if (out_qeoi_page)
> +		*out_qeoi_page =3D be64_to_cpu(qeoi_page);
> +	if (out_escalate_irq)
> +		*out_escalate_irq =3D be32_to_cpu(escalate_irq);
> +	if (out_qflags)
> +		*out_qflags =3D be64_to_cpu(qflags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xive_native_get_queue_info);
> +
> +int xive_native_get_queue_state(u32 vp_id, u32 prio, u32 *qtoggle, u32 *=
qindex)
> +{
> +	__be32 opal_qtoggle;
> +	__be32 opal_qindex;
> +	s64 rc;
> +
> +	rc =3D opal_xive_get_queue_state(vp_id, prio, &opal_qtoggle,
> +				       &opal_qindex);
> +	if (rc) {
> +		pr_err("OPAL failed to get queue state for VCPU %d/%d : %lld\n",
> +		       vp_id, prio, rc);
> +		return -EIO;
> +	}
> +
> +	if (qtoggle)
> +		*qtoggle =3D be32_to_cpu(opal_qtoggle);
> +	if (qindex)
> +		*qindex =3D be32_to_cpu(opal_qindex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xive_native_get_queue_state);
> +
> +int xive_native_set_queue_state(u32 vp_id, u32 prio, u32 qtoggle, u32 qi=
ndex)
> +{
> +	s64 rc;
> +
> +	rc =3D opal_xive_set_queue_state(vp_id, prio, qtoggle, qindex);
> +	if (rc) {
> +		pr_err("OPAL failed to set queue state for VCPU %d/%d : %lld\n",
> +		       vp_id, prio, rc);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xive_native_set_queue_state);
> +
> +int xive_native_get_vp_state(u32 vp_id, u64 *out_state)
> +{
> +	__be64 state;
> +	s64 rc;
> +
> +	rc =3D opal_xive_get_vp_state(vp_id, &state);
> +	if (rc) {
> +		pr_err("OPAL failed to get vp state for VCPU %d : %lld\n",
> +		       vp_id, rc);
> +		return -EIO;
> +	}
> +
> +	if (out_state)
> +		*out_state =3D be64_to_cpu(state);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xive_native_get_vp_state);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerp=
c/platforms/powernv/opal-wrappers.S
> index f4875fe3f8ff..3179953d6b56 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -309,6 +309,9 @@ OPAL_CALL(opal_xive_get_vp_info,		OPAL_XIVE_GET_VP_IN=
FO);
>  OPAL_CALL(opal_xive_set_vp_info,		OPAL_XIVE_SET_VP_INFO);
>  OPAL_CALL(opal_xive_sync,			OPAL_XIVE_SYNC);
>  OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
> +OPAL_CALL(opal_xive_get_queue_state,		OPAL_XIVE_GET_QUEUE_STATE);
> +OPAL_CALL(opal_xive_set_queue_state,		OPAL_XIVE_SET_QUEUE_STATE);
> +OPAL_CALL(opal_xive_get_vp_state,		OPAL_XIVE_GET_VP_STATE);
>  OPAL_CALL(opal_signal_system_reset,		OPAL_SIGNAL_SYSTEM_RESET);
>  OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
>  OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzK+sACgkQbDjKyiDZ
s5JUTg//TZFNo8MOXus8ZzfIpa1zDD/u99I/aXQeyUEhd9lEnHLuaPsoaFjRk8QK
1+Aovz8N5OnDW2UI+AczHyWbUwcy3a66QwlGYmM8zKYjoDU6zvI/UlSrNbvDUcbh
UGArmRSjKeRVsDmGD8izj19ScBYsjNA/3ztSr4AQ2CwBHy3rzMl04lKfcUxEsmRT
8qmBFsLMbmFRFAmwMzG2gJ9x1Xg2oWEs+RAs2ABX98QBkwxSgy/nJbwgJpkP1sy3
/5rZ0VqPMN75FtLntQSYvNnsvxOo90X9yjIzRtwsOIN3asi1C3PLb/YVGtw7sRXO
1JcWwbbxvKDbMKj+ZNYJY0iujNpG6/0t8QXo2JMNMwyeX76hjYgxZMhXULsljcfA
kkv0w3756vX9SS9P+xEtHVOc+8NTROWwrj2wDcTg5itTziACLKEr4MhfXVrpYkNF
P3wqqAe4P42L8H9KkYTPfDLpCKHxLZa+XdAUPEUuO3mEWqHMWfokE/3ou5Z93SgE
IOeAXIcxGWbfk9YOqJIk1MyF7MbZMmUhSemS6A8tf2nHda7+ewdcflEeH5Ryq3P3
FVDY4M0Gcxk4MzUfnaMYohrmf1DiAhPCjiu323ziIaYghmjEUrNgEUn6gdBS9Yin
u410fqUIg9g0IJg4x4+ZoL1Vv1Dzg60jbknSpqsMg6K3OFt4HjM=
=mQ2S
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
