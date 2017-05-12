Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPFxK0jT0zDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 13:35:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] powerpc/32: tlbie provide L operand explicitly
In-Reply-To: <20170511151522.4772-2-npiggin@gmail.com>
References: <20170511151522.4772-1-npiggin@gmail.com>
 <20170511151522.4772-2-npiggin@gmail.com>
Date: Fri, 12 May 2017 13:35:48 +1000
Message-ID: <87lgq2bvcb.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> The single-operand form of tlbie used to be accepted as the second
> operand (L) being implicitly 0. Newer binutils reject this.
>
> Change remaining single-op tlbie instructions to have explicit 0
> second argument.

Do old(er) binutils accept the two operand version?

cheers
