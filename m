Return-Path: <srs0=nfy5=34=axtens.net=dja@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7fQL1n2NzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:10:18 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w7fQL06WFz8w1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:10:18 +1000 (AEST)
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w7fQK0HHlz9s78
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2017 10:10:17 +1000 (AEST)
Received: by mail-io0-x236.google.com with SMTP id a103so44714252ioj.1
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2017 17:10:16 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, herbert@gondor.apana.org.au
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/crypto/crct10dif-vpmsum: Fix missing
 preempt_disable()
In-Reply-To: <1492578458-26252-1-git-send-email-mpe@ellerman.id.au>
References: <1492578458-26252-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 20 Apr 2017 10:10:09 +1000
Message-ID: <877f2gaqhq.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> Fixes: b01df1c16c9a ("crypto: powerpc - Add CRC-T10DIF acceleration")

Thank you very much for doing this! (and my apologies for not doing it
myself!)

It all looks good to me.

I think an Ack is appropriate in these circumstances?
Acked-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel
