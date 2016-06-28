Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf3gb1dnlzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:15 +1000 (AEST)
Message-ID: <1467113833.16036.8.camel@ellerman.id.au>
Subject: Re: [PATCH 07/17] powerpc/opal: Add real mode call wrappers
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Cc: shreyas <shreyas@linux.vnet.ibm.com>
Date: Tue, 28 Jun 2016 21:37:13 +1000
In-Reply-To: <1467087495.29717.4.camel@neuling.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
 <1467030333-31435-8-git-send-email-benh@kernel.crashing.org>
 <1467087495.29717.4.camel@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-28 at 14:18 +1000, Michael Neuling wrote:
> mpe,
> 
> Just flagging this as going to conflict with Shreyas' stop instruction
> patch series.  It's relatively easy to fix so you can do it manually.
> 
> Alternatively you could take this one patch now and get Shreyas to rebase.

Yeah Ben already told me.

I don't know which will go in first yet, this has had zero revisions and zero
reviews so it might not go in straight away ;)

I'm happy to fix up whatever merge conflicts and/or get people to rebase, it's
no problem.

cheers
