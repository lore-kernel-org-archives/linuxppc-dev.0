Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0PMl4gSbzDqPN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 17:57:07 +1000 (AEST)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s0PMk6r0tz9t1b
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 17:57:06 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id iw10so18622289pac.2
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 00:57:06 -0700 (PDT)
Date: Thu, 28 Jul 2016 17:56:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 21/21] powerpc/jump_label: Annotate jump label assembly
Message-ID: <20160728175658.74405e08@roar.ozlabs.ibm.com>
In-Reply-To: <1469629097-30859-21-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-21-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 Jul 2016 00:18:17 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Add a comment to the generated assembler for jump labels. This makes
> it easier to identify them in asm listings (generated with $ make
> foo.s).

The series looks in much better shape now.

As a disclaimer I did not go through the shuffling around of the early
init code too closely, and I don't know that part of the arch very
well. But other than that it looks good.

Thanks,
Nick
