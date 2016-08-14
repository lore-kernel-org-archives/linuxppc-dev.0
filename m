Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sBmJ51NMwzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 14:44:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 14/21] powerpc: Call jump_label_init() in
 apply_feature_fixups()
In-Reply-To: <87shu88brq.fsf@linux-m68k.org>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-14-git-send-email-mpe__30163.7288918302$1469630223$gmane$org@ellerman.id.au>
 <87shu88brq.fsf@linux-m68k.org>
Date: Sun, 14 Aug 2016 14:44:49 +1000
Message-ID: <87popcq7r2.fsf@concordia.ellerman.id.au>
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

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jul 28 2016, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>
>> Call jump_label_init() early so that we can use static keys for CPU and
>> MMU feature checks.
>
> That breaks PPC32.  jump_label_init doesn't use PTRRELOC.

Should be fixed in Linus' tree:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=97f6e0cc35026a2a09147a6da636d901525e1969

cheers
