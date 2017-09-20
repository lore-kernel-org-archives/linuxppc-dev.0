Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxyYn4y9nzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 21:43:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] powerpc: Handle MCE on POWER9 with only DSISR bit 33
 set
In-Reply-To: <20170915052549.8105-2-mikey@neuling.org>
References: <20170915052549.8105-1-mikey@neuling.org>
 <20170915052549.8105-2-mikey@neuling.org>
Date: Wed, 20 Sep 2017 21:43:40 +1000
Message-ID: <8760cdlhn7.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:

> On POWER9 DD2.1 and below, it's possible to get Machine Check
> Exception (MCE) where only DSISR bit 33 is set. This will result in
> the linux MCE handler seeing an unknown event, which triggers linux to
> crash.

Why do we get a machine check with just one bit set, and why is it OK to
just treat it as handled without doing anything?

Is it just entirely spurious?

cheers
