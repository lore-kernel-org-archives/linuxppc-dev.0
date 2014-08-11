Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95BDD1A0718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 18:51:16 +1000 (EST)
Message-ID: <1407747061.4508.75.camel@pasglop>
Subject: Re: [PATCH v3] powerpc/kvm: support to handle sw breakpoint
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Mon, 11 Aug 2014 18:51:01 +1000
In-Reply-To: <53E87023.6080200@suse.de>
References: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53E87023.6080200@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-11 at 09:26 +0200, Alexander Graf wrote:
> > diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> > index da86d9b..d95014e 100644
> > --- a/arch/powerpc/kvm/emulate.c
> > +++ b/arch/powerpc/kvm/emulate.c
> 
> This should be book3s_emulate.c.

Any reason we can't make that 00dddd00 opcode as breakpoint common to
all powerpc variants ?

Cheers,
Ben.
