Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkPsb6v3GzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:31:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc/pasemi,
 cbe: Do not process decremeter or external wakeup from powersave
In-Reply-To: <20170315154350.6256-1-npiggin@gmail.com>
References: <20170315154350.6256-1-npiggin@gmail.com>
Date: Thu, 16 Mar 2017 21:31:43 +1100
Message-ID: <874lytldgw.fsf@concordia.ellerman.id.au>
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
> I would like to start using a dedicated stack for system reset interrupt
> and treat it as a Linux nmi, which makes it tricky to call complex
> interrupt handlers directly from the system reset trap handler.
>
> So I would like to remove the decrementer and external handler calls from
> Cell and Pasemi platforms' system reset handler. I think we can just
> remove them if they can be handled when they re-fire as normal interrupts?
> At the moment I don't have environments set up to test if this works.

My QS22 has booted OK with it applied, so it seems OK.

I'll test it a bit more tomorrow.

cheers
