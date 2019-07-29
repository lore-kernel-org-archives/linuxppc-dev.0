Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB38C433FF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 09:40:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FDF20679
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 09:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FDF20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xvmj6HDCzDqLK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 19:40:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=liviu.dudau@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 45xvkY3TwnzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 19:38:07 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86135344;
 Mon, 29 Jul 2019 02:38:04 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 468AE3F694;
 Mon, 29 Jul 2019 02:38:04 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
 id C804368240B; Mon, 29 Jul 2019 10:38:02 +0100 (BST)
Date: Mon, 29 Jul 2019 10:38:02 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Pei Hsuan Hung <afcidk@gmail.com>
Subject: Re: [PATCH] Fix typo reigster to register
Message-ID: <20190729093802.y33mfklarh23yngl@e110455-lin.cambridge.arm.com>
References: <20190727142111.20039-1-afcidk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190727142111.20039-1-afcidk@gmail.com>
User-Agent: NeoMutt/20180716
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Oliver O'Halloran <oohall@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 linux-scsi@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Kalle Valo <kvalo@codeaurora.org>,
 trivial@kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brian Starkey <brian.starkey@arm.com>, Jeremy Kerr <jk@ozlabs.org>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Larry Finger <Larry.Finger@lwfinger.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Pei,

On Sat, Jul 27, 2019 at 10:21:09PM +0800, Pei Hsuan Hung wrote:
> Signed-off-by: Pei Hsuan Hung <afcidk@gmail.com>
> Cc: trivial@kernel.org
> ---
>  arch/powerpc/kernel/eeh.c                           | 2 +-
>  arch/powerpc/platforms/cell/spufs/switch.c          | 4 ++--
>  drivers/extcon/extcon-rt8973a.c                     | 2 +-
>  drivers/gpu/drm/arm/malidp_regs.h                   | 2 +-
>  drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h | 2 +-
>  drivers/scsi/lpfc/lpfc_hbadisc.c                    | 4 ++--
>  fs/userfaultfd.c                                    | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index c0e4b73191f3..d75c9c24ec4d 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1030,7 +1030,7 @@ int __init eeh_ops_register(struct eeh_ops *ops)
>  }
>  
>  /**
> - * eeh_ops_unregister - Unreigster platform dependent EEH operations
> + * eeh_ops_unregister - Unregister platform dependent EEH operations
>   * @name: name of EEH platform operations
>   *
>   * Unregister the platform dependent EEH operation callback
> diff --git a/arch/powerpc/platforms/cell/spufs/switch.c b/arch/powerpc/platforms/cell/spufs/switch.c
> index 5c3f5d088c3b..9548a086937b 100644
> --- a/arch/powerpc/platforms/cell/spufs/switch.c
> +++ b/arch/powerpc/platforms/cell/spufs/switch.c
> @@ -574,7 +574,7 @@ static inline void save_mfc_rag(struct spu_state *csa, struct spu *spu)
>  {
>  	/* Save, Step 38:
>  	 *     Save RA_GROUP_ID register and the
> -	 *     RA_ENABLE reigster in the CSA.
> +	 *     RA_ENABLE register in the CSA.
>  	 */
>  	csa->priv1.resource_allocation_groupID_RW =
>  		spu_resource_allocation_groupID_get(spu);
> @@ -1227,7 +1227,7 @@ static inline void restore_mfc_rag(struct spu_state *csa, struct spu *spu)
>  {
>  	/* Restore, Step 29:
>  	 *     Restore RA_GROUP_ID register and the
> -	 *     RA_ENABLE reigster from the CSA.
> +	 *     RA_ENABLE register from the CSA.
>  	 */
>  	spu_resource_allocation_groupID_set(spu,
>  			csa->priv1.resource_allocation_groupID_RW);
> diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
> index 40c07f4d656e..e75c03792398 100644
> --- a/drivers/extcon/extcon-rt8973a.c
> +++ b/drivers/extcon/extcon-rt8973a.c
> @@ -270,7 +270,7 @@ static int rt8973a_muic_get_cable_type(struct rt8973a_muic_info *info)
>  	}
>  	cable_type = adc & RT8973A_REG_ADC_MASK;
>  
> -	/* Read Device 1 reigster to identify correct cable type */
> +	/* Read Device 1 register to identify correct cable type */
>  	ret = regmap_read(info->regmap, RT8973A_REG_DEV1, &dev1);
>  	if (ret) {
>  		dev_err(info->dev, "failed to read DEV1 register\n");
> diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> index 993031542fa1..0d81b34a4212 100644
> --- a/drivers/gpu/drm/arm/malidp_regs.h
> +++ b/drivers/gpu/drm/arm/malidp_regs.h
> @@ -145,7 +145,7 @@
>  #define     MALIDP_SE_COEFFTAB_DATA_MASK	0x3fff
>  #define     MALIDP_SE_SET_COEFFTAB_DATA(x) \
>  		((x) & MALIDP_SE_COEFFTAB_DATA_MASK)
> -/* Enhance coeffents reigster offset */
> +/* Enhance coeffents register offset */

Unless this patch was generated by a script I think it is worth correcting the
other spelling mistake on that line as well: coefficients rather than coeffents.

With that: Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

>  #define MALIDP_SE_IMAGE_ENH			0x3C
>  /* ENH_LIMITS offset 0x0 */
>  #define     MALIDP_SE_ENH_LOW_LEVEL		24
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h
> index 99c6f7eefd85..d03c8f12a15c 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h
> @@ -58,7 +58,7 @@ struct fw_priv {
>  	/* 0x81: PCI-AP, 01:PCIe, 02: 92S-U,
>  	 * 0x82: USB-AP, 0x12: 72S-U, 03:SDIO */
>  	u8 hci_sel;
> -	/* the same value as reigster value  */
> +	/* the same value as register value  */
>  	u8 chip_version;
>  	/* customer  ID low byte */
>  	u8 customer_id_0;
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index 28ecaa7fc715..9e116bd79836 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -6551,7 +6551,7 @@ lpfc_sli4_unregister_fcf(struct lpfc_hba *phba)
>   * lpfc_unregister_fcf_rescan - Unregister currently registered fcf and rescan
>   * @phba: Pointer to hba context object.
>   *
> - * This function unregisters the currently reigstered FCF. This function
> + * This function unregisters the currently registered FCF. This function
>   * also tries to find another FCF for discovery by rescan the HBA FCF table.
>   */
>  void
> @@ -6609,7 +6609,7 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
>   * lpfc_unregister_fcf - Unregister the currently registered fcf record
>   * @phba: Pointer to hba context object.
>   *
> - * This function just unregisters the currently reigstered FCF. It does not
> + * This function just unregisters the currently registered FCF. It does not
>   * try to find another FCF for discovery.
>   */
>  void
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index ccbdbd62f0d8..612dc1240f90 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -267,7 +267,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  /*
> - * Verify the pagetables are still not ok after having reigstered into
> + * Verify the pagetables are still not ok after having registered into
>   * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
>   * userfault that has already been resolved, if userfaultfd_read and
>   * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
