Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E8C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 05:11:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2AA6056B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 05:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D2AA6056B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpfJB0m1rz3d9r
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 15:11:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpfHG362Hz2xlG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 15:10:18 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GpfHB5Plvz9sVJ;
 Tue, 17 Aug 2021 07:10:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5mFK6t36tBf; Tue, 17 Aug 2021 07:10:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GpfHB4R5yz9sV9;
 Tue, 17 Aug 2021 07:10:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 724B38B76D;
 Tue, 17 Aug 2021 07:10:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id WJZEQP7I72dA; Tue, 17 Aug 2021 07:10:14 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A67B8B765;
 Tue, 17 Aug 2021 07:10:14 +0200 (CEST)
Subject: Re: [PATCH v2 3/3] powerpc/configs: Regenerate mpc885_ads_defconfig
To: Joel Stanley <joel@jms.id.au>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <20210817045407.2445664-1-joel@jms.id.au>
 <20210817045407.2445664-4-joel@jms.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9be0f123-157e-9ec4-7cbe-3b71d064a93d@csgroup.eu>
Date: Tue, 17 Aug 2021 07:10:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817045407.2445664-4-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 17/08/2021 à 06:54, Joel Stanley a écrit :
> Regenerate atop v5.14-rc6 by doing a make savedefconfig.
> 
> The changes a re-ordering except for the following (which are still set
> indirectly):
> 
>   - CONFIG_DEBUG_KERNEL=y selected by EXPERT
> 
>   - CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xff002008 which is the default
>     setting
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/configs/mpc885_ads_defconfig | 46 +++++++++++------------
>   1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
> index cd08f9ed2c8d..c74dc76b1d0d 100644
> --- a/arch/powerpc/configs/mpc885_ads_defconfig
> +++ b/arch/powerpc/configs/mpc885_ads_defconfig
> @@ -1,19 +1,30 @@
> -CONFIG_PPC_8xx=y
>   # CONFIG_SWAP is not set
>   CONFIG_SYSVIPC=y
>   CONFIG_NO_HZ=y
>   CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BPF_JIT=y
> +CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
>   CONFIG_LOG_BUF_SHIFT=14
>   CONFIG_EXPERT=y
>   # CONFIG_ELF_CORE is not set
>   # CONFIG_BASE_FULL is not set
>   # CONFIG_FUTEX is not set
> +CONFIG_PERF_EVENTS=y
>   # CONFIG_VM_EVENT_COUNTERS is not set
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_PARTITION_ADVANCED=y
> +CONFIG_PPC_8xx=y
> +CONFIG_8xx_GPIO=y
> +CONFIG_SMC_UCODE_PATCH=y
> +CONFIG_PIN_TLB=y
>   CONFIG_GEN_RTC=y
>   CONFIG_HZ_100=y
> +CONFIG_MATH_EMULATION=y
> +CONFIG_PPC_16K_PAGES=y
> +CONFIG_ADVANCED_OPTIONS=y
>   # CONFIG_SECCOMP is not set
> +CONFIG_STRICT_KERNEL_RWX=y
> +CONFIG_MODULES=y
> +# CONFIG_BLK_DEV_BSG is not set
> +CONFIG_PARTITION_ADVANCED=y
>   CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_UNIX=y
> @@ -46,38 +57,25 @@ CONFIG_DAVICOM_PHY=y
>   # CONFIG_LEGACY_PTYS is not set
>   CONFIG_SERIAL_CPM=y
>   CONFIG_SERIAL_CPM_CONSOLE=y
> +CONFIG_SPI=y
> +CONFIG_SPI_FSL_SPI=y
>   # CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
> +CONFIG_8xxx_WDT=y
>   # CONFIG_USB_SUPPORT is not set
>   # CONFIG_DNOTIFY is not set
>   CONFIG_TMPFS=y
>   CONFIG_CRAMFS=y
>   CONFIG_NFS_FS=y
>   CONFIG_ROOT_NFS=y
> +CONFIG_CRYPTO=y
> +CONFIG_CRYPTO_DEV_TALITOS=y
>   CONFIG_CRC32_SLICEBY4=y
>   CONFIG_DEBUG_INFO=y
>   CONFIG_MAGIC_SYSRQ=y
> -CONFIG_DETECT_HUNG_TASK=y
> -CONFIG_PPC_16K_PAGES=y
> -CONFIG_DEBUG_KERNEL=y
>   CONFIG_DEBUG_FS=y
> -CONFIG_PPC_PTDUMP=y
> -CONFIG_MODULES=y
> -CONFIG_SPI=y
> -CONFIG_SPI_FSL_SPI=y
> -CONFIG_CRYPTO=y
> -CONFIG_CRYPTO_DEV_TALITOS=y
> -CONFIG_8xx_GPIO=y
> -CONFIG_WATCHDOG=y
> -CONFIG_8xxx_WDT=y
> -CONFIG_SMC_UCODE_PATCH=y
> -CONFIG_ADVANCED_OPTIONS=y
> -CONFIG_PIN_TLB=y
> -CONFIG_PERF_EVENTS=y
> -CONFIG_MATH_EMULATION=y
> -CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
> -CONFIG_STRICT_KERNEL_RWX=y
> -CONFIG_BPF_JIT=y
>   CONFIG_DEBUG_VM_PGTABLE=y
> +CONFIG_DETECT_HUNG_TASK=y
>   CONFIG_BDI_SWITCH=y
>   CONFIG_PPC_EARLY_DEBUG=y
> -CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xff002008
> +CONFIG_PPC_PTDUMP=y
> 
