Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D1DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 05:27:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6BE614A7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 05:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6BE614A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8dHy1Hllz30N9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 16:27:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8dHZ1zrQz302Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 16:27:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F8dHS21p8z9txMX;
 Tue, 30 Mar 2021 07:27:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id naoeN3z5vJR4; Tue, 30 Mar 2021 07:27:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F8dHS0hpCz9txMR;
 Tue, 30 Mar 2021 07:27:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 45C478B7E7;
 Tue, 30 Mar 2021 07:27:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zWGKYTYcdLJg; Tue, 30 Mar 2021 07:27:16 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B54E58B75B;
 Tue, 30 Mar 2021 07:27:15 +0200 (CEST)
Subject: Re: [PATCH v10 08/10] powerpc/configs: Enable STRICT_MODULE_RWX in
 skiroot_defconfig
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20210330045132.722243-1-jniethe5@gmail.com>
 <20210330045132.722243-9-jniethe5@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c511660d-64e3-30fa-9324-8019928545d5@csgroup.eu>
Date: Tue, 30 Mar 2021 07:27:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330045132.722243-9-jniethe5@gmail.com>
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
Cc: ajd@linux.ibm.com, Joel Stanley <joel@joel.id.au>, npiggin@gmail.com,
 cmr@codefail.de, naveen.n.rao@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 30/03/2021 à 06:51, Jordan Niethe a écrit :
> From: Russell Currey <ruscur@russell.cc>
> 
> skiroot_defconfig is the only powerpc defconfig with STRICT_KERNEL_RWX
> enabled, and if you want memory protection for kernel text you'd want it
> for modules too, so enable STRICT_MODULE_RWX there.

Maybe we could now selectt ARCH_OPTIONAL_KERNEL_RWX_DEFAULT in arch/powerpc/Kconfig.

Then this change would not be necessary.

Would be in line with https://github.com/linuxppc/issues/issues/223


> 
> Acked-by: Joel Stanley <joel@joel.id.au>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>   arch/powerpc/configs/skiroot_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
> index b806a5d3a695..50fe06cb3a31 100644
> --- a/arch/powerpc/configs/skiroot_defconfig
> +++ b/arch/powerpc/configs/skiroot_defconfig
> @@ -50,6 +50,7 @@ CONFIG_CMDLINE="console=tty0 console=hvc0 ipr.fast_reboot=1 quiet"
>   # CONFIG_PPC_MEM_KEYS is not set
>   CONFIG_JUMP_LABEL=y
>   CONFIG_STRICT_KERNEL_RWX=y
> +CONFIG_STRICT_MODULE_RWX=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
>   CONFIG_MODULE_SIG_FORCE=y
> 
