Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49D0C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 09:43:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13A420837
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 09:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13A420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Bkt0091LzF0dc
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 20:43:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Bkqp2Ft2zF0Ql
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 20:41:25 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Bkqg3xtmz9vGyC;
 Sat,  8 Dec 2018 10:41:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id O9mKpkrYBSLy; Sat,  8 Dec 2018 10:41:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Bkqg3QRrz9vGyB;
 Sat,  8 Dec 2018 10:41:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E1308B78A;
 Sat,  8 Dec 2018 10:41:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rOQA5nMWI5wW; Sat,  8 Dec 2018 10:41:20 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 55FE88B74C;
 Sat,  8 Dec 2018 10:41:20 +0100 (CET)
Subject: =?UTF-8?Q?Re=3a_error=3a_no_previous_prototype_for_=e2=80=98pt=5fre?=
 =?UTF-8?B?Z3NfY2hlY2vigJk=?=
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <CA+7wUsxwnYwr+0GrANN01VV_V9-0p5h==eBcCmNm-XEZYhwbOg@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <45fce287-a302-2632-0499-a2f208cc352e@c-s.fr>
Date: Sat, 8 Dec 2018 10:41:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CA+7wUsxwnYwr+0GrANN01VV_V9-0p5h==eBcCmNm-XEZYhwbOg@mail.gmail.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu,

Le 07/12/2018 à 21:07, Mathieu Malaterre a écrit :
> Michael,
> 
> I have been wondering for a while now, but I failed to make sense of
> this function: pt_regs_check (commit 002af9391bfbe). What is this
> function meant for ?

AFAICS this is a dummy function, its purpose is to break the build if 
struct pt_regs and struct user_pt_regs don't match.

> 
> Background, it breaks my W=1 build with:
> 
> ../arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype
> for ‘pt_regs_check’ [-Werror=missing-prototypes]

What about adding a prototype for it on the line above ?

> 
> I failed to find a usage of it within the linux source tree... (git
> grep pt_regs_check returns nothing).

This function has no functionnal purpose, and will get eliminated at 
link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINATION


Christophe
> 
> Thanks,
> 
