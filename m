Return-Path: <SRS0=Sqku=EL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F2C00A89
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 07:07:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B16D2080D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 07:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B16D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CRZMW0pqVzDqss
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 18:07:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CRZKj3pF5zDqfY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2020 18:05:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CRZKM47t1z9v117;
 Thu,  5 Nov 2020 08:05:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id b4BaAEdbvgaQ; Thu,  5 Nov 2020 08:05:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CRZKM3KnPz9v116;
 Thu,  5 Nov 2020 08:05:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 40D2E8B819;
 Thu,  5 Nov 2020 08:05:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QNSBaGaQp51J; Thu,  5 Nov 2020 08:05:12 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E8EB58B764;
 Thu,  5 Nov 2020 08:05:10 +0100 (CET)
Subject: Re: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable
 __always_unused
To: Lee Jones <lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-35-lee.jones@linaro.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
Date: Thu, 5 Nov 2020 08:04:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201104193549.4026187-35-lee.jones@linaro.org>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/11/2020 à 20:35, Lee Jones a écrit :
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/serial/pmac_zilog.h:365:58: warning: variable ‘garbage’ set but not used [-Wunused-but-set-variable]

Explain how you are fixing this warning.

Setting  __always_unused is usually not the good solution for fixing this warning, but here I guess 
this is likely the good solution. But it should be explained why.

Christophe


> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linux-serial@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/tty/serial/pmac_zilog.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
> index bb874e76810e0..968aec7c1cf82 100644
> --- a/drivers/tty/serial/pmac_zilog.h
> +++ b/drivers/tty/serial/pmac_zilog.h
> @@ -362,7 +362,7 @@ static inline void zssync(struct uart_pmac_port *port)
>   
>   /* Misc macros */
>   #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
> -#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
> +#define ZS_CLEARFIFO(port)   do { volatile unsigned char __always_unused garbage; \
>   				     garbage = read_zsdata(port); \
>   				     garbage = read_zsdata(port); \
>   				     garbage = read_zsdata(port); \
> 
