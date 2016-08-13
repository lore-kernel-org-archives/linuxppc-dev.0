Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sBdtC5KWgzDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 09:55:31 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sBdt95XRkz9t0P
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Aug 2016 09:55:29 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 14/21] powerpc: Call jump_label_init() in
 apply_feature_fixups()
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-14-git-send-email-mpe__30163.7288918302$1469630223$gmane$org@ellerman.id.au>
Date: Sun, 14 Aug 2016 01:55:21 +0200
In-Reply-To: <1469629097-30859-14-git-send-email-mpe__30163.7288918302$1469630223$gmane$org@ellerman.id.au>
 (Michael Ellerman's message of "Thu, 28 Jul 2016 00:18:10 +1000")
Message-ID: <87shu88brq.fsf@linux-m68k.org>
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

On Jul 28 2016, Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> Call jump_label_init() early so that we can use static keys for CPU and
> MMU feature checks.

That breaks PPC32.  jump_label_init doesn't use PTRRELOC.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
