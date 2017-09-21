Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyYnH1KPYzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 21:10:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/5] More NMI IPI enablement work
In-Reply-To: <20170918082706.6485-1-npiggin@gmail.com>
References: <20170918082706.6485-1-npiggin@gmail.com>
Date: Thu, 21 Sep 2017 21:10:42 +1000
Message-ID: <87vakcb93h.fsf@concordia.ellerman.id.au>
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

> Hi,
>
> Here is the NMI IPI enablement for powernv, which requires
> supported firmware and hardware:
>
> https://lists.ozlabs.org/pipermail/skiboot/2017-September/009111.html
>
> And some preceeding patches that fix issues I ran into when
> testing it.

Are any of these critical such that I should pick them up for 4.14 or
earlier?

cheers
