Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf45n4f3XzDqmk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:56:29 +1000 (AEST)
Message-ID: <1467114975.20278.124.camel@kernel.crashing.org>
Subject: Re: [PATCH 07/17] powerpc/opal: Add real mode call wrappers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, linuxppc-dev@ozlabs.org
Cc: shreyas <shreyas@linux.vnet.ibm.com>
Date: Tue, 28 Jun 2016 21:56:15 +1000
In-Reply-To: <1467113833.16036.8.camel@ellerman.id.au>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
 <1467030333-31435-8-git-send-email-benh@kernel.crashing.org>
 <1467087495.29717.4.camel@neuling.org>
 <1467113833.16036.8.camel@ellerman.id.au>
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

On Tue, 2016-06-28 at 21:37 +1000, Michael Ellerman wrote:
> Yeah Ben already told me.
> 
> I don't know which will go in first yet, this has had zero revisions and zero
> reviews so it might not go in straight away ;)

The point was that patch could go in independently of the rest but I really
don't care either way.

> I'm happy to fix up whatever merge conflicts and/or get people to rebase, it's
> no problem.

Yup and rebasing my patch on top of Shreyas is not a big deal wither, I
did it at least twice in internal trees already ;-)

Cheers,
Ben.
