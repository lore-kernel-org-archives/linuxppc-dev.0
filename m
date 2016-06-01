Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKFcr3mskzDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 13:06:36 +1000 (AEST)
Message-ID: <1464750396.19731.0.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: Avoid load hit store in __giveup_fpu() and
 __giveup_altivec()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, Gabriel Paubert <paubert@iram.es>
Cc: benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com,  acsawdey@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 01 Jun 2016 13:06:36 +1000
In-Reply-To: <20160531200921.53a44e15@kryten>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
 <20160530081552.GA2547@visitor2.iram.es> <20160531200921.53a44e15@kryten>
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

On Tue, 2016-05-31 at 20:09 +1000, Anton Blanchard wrote:
> > Huh? Make it an unsigned long please, which is the type of the msr
> > field in struct pt_regs to work on both 32 and 64 bit processors.
> 
> Thanks, not sure what I was thinking there. Will respin.

I'll fix it up here.

cheers
