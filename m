Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szWRr2FstzDt3m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 23:27:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3szWRq6k4xz9t0w
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Oct 2016 23:27:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc/hash64: Be more careful when generating tlbiel
In-Reply-To: <1476856405-4811-1-git-send-email-mpe@ellerman.id.au>
References: <1476856405-4811-1-git-send-email-mpe@ellerman.id.au>
Date: Wed, 19 Oct 2016 23:27:51 +1100
Message-ID: <87a8e04j7c.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> From: Balbir Singh <bsingharora@gmail.com>
...
>
> Although there may be very old toolchains which don't understand tlbiel, we have
> other code in the tree which has been using tlbiel for over five years, and no
> one has reported any build failures, so just let the assembler generate the
> instructions.

Turns out this part is not true, it depends on the -mcpu you pass. So
we'll have to go back to using the macros for generating the two
argument form. v3 to come.

cheers
