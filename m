Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mx6936cfzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 17:08:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] powerpc/powernv: Add support for NPU2 relaxed-ordering
 mode
In-Reply-To: <1533698243-25972-1-git-send-email-arbab@linux.ibm.com>
References: <1533698243-25972-1-git-send-email-arbab@linux.ibm.com>
Date: Fri, 10 Aug 2018 17:07:56 +1000
Message-ID: <87pnyq8zsj.fsf@concordia.ellerman.id.au>
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

Reza Arbab <arbab@linux.ibm.com> writes:
> From: Alistair Popple <alistair@popple.id.au>
>
> Some device drivers support out of order access to GPU memory. This does
> not affect the CPU view of memory but it does affect the GPU view, so it
> should only be enabled once the GPU driver has requested it. Add APIs
> allowing a driver to do so.

Do we have any indication which drivers we are expecting to use this?

I'd prefer not to merge a new API unless we at least have some idea
what's going to use it.

cheers
