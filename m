Return-Path: <rusty@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 639441A073D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 13:21:20 +1100 (AEDT)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] kernel/cpu.c: eliminate some indirection
In-Reply-To: <877fmlno8o.fsf@rasmusvillemoes.dk>
References: <1444144919-25143-1-git-send-email-linux@rasmusvillemoes.dk>
 <877fmlno8o.fsf@rasmusvillemoes.dk>
Date: Sun, 18 Oct 2015 12:11:44 +1030
Message-ID: <87y4f1x89z.fsf@rustcorp.com.au>
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

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
> On Tue, Oct 06 2015, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
>> v2: fix build failure on ppc, add acks.
>
> Does anyone want to take these through their tree?

I think the x86 tree is the least illogical place, unless akpm wants it?

Cheers,
Rusty.
