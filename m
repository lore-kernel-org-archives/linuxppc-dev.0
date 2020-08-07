Return-Path: <SRS0=mIln=BR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625BDC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 14:58:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0465B221E2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 14:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0465B221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BNT5W66LwzDqbG
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2020 00:58:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=fail (SPF fail - not authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.2; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
X-Greylist: delayed 1328 seconds by postgrey-1.36 at bilbo;
 Sat, 08 Aug 2020 00:53:40 AEST
Received: from pegase2.c-s.fr (vpn2.c-s.fr [93.17.235.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BNSzS5vTszDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2020 00:53:39 +1000 (AEST)
Received: from localhost (mailhub2-ext [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4BNSTj0v49z9ttfp;
 Fri,  7 Aug 2020 16:31:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [172.26.127.65]) (amavisd-new, port 10024)
 with ESMTP id cj3w-Q5bmpO7; Fri,  7 Aug 2020 16:31:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4BNSTj05PQz9ttfn;
 Fri,  7 Aug 2020 16:31:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E2FC8BBAD;
 Fri,  7 Aug 2020 16:31:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id TRVENUZcnl2M; Fri,  7 Aug 2020 16:31:23 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AD738BBA8;
 Fri,  7 Aug 2020 16:31:22 +0200 (CEST)
Subject: Re: [PATCH] powerpc:entry_32: correct the path and function name in
 the comment
To: chenzefeng <chenzefeng2@huawei.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, christophe.leroy@c-s.fr,
 tglx@linutronix.de, bigeasy@linutronix.de, npiggin@gmail.com
References: <20200807101956.67454-1-chenzefeng2@huawei.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b8d70e7a-7dc8-ef46-9e84-7f03d68a151b@csgroup.eu>
Date: Fri, 7 Aug 2020 16:31:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807101956.67454-1-chenzefeng2@huawei.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 zengweilin@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 07/08/2020 à 12:19, chenzefeng a écrit :
> Update the comment for file's directory and function name changed.
> 
> Fixes: facd04a904ff ("powerpc: convert to copy_thread_tls")
> Fixes: 14cf11af6cf6 ("powerpc: Merge enough to start building in arch/powerpc.")
> 
> Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
> ---
>   arch/powerpc/kernel/entry_32.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 8420abd4ea1c..9937593d3a33 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -696,8 +696,8 @@ handle_dabr_fault:
>    * to the "_switch" path.  If you change this , you'll have to
>    * change the fork code also.
>    *
> - * The code which creates the new task context is in 'copy_thread'
> - * in arch/ppc/kernel/process.c
> + * The code which creates the new task context is in 'copy_thread_tls'
> + * in arch/powerpc/kernel/process.c

Does it matters at all where the function is ? I'm sure people can find 
it themselves.

Christophe

>    */
>   _GLOBAL(_switch)
>   	stwu	r1,-INT_FRAME_SIZE(r1)
> 
