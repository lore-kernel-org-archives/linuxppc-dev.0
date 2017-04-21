Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8cWg1VlSzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:48:15 +1000 (AEST)
Date: Fri, 21 Apr 2017 22:48:04 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCH v3 6/7] powerpc: kprobes: emulate instructions on kprobe
 handler re-entry
Message-Id: <20170421224804.4213332fafa6d9fe18868fa1@kernel.org>
In-Reply-To: <87lgqv4ni9.fsf@concordia.ellerman.id.au>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <0d4193a90e4b2ad3cd2ef33d41228b80a2ac9f91.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170419234319.7893df9c158e565fede4a386@kernel.org>
 <1492620027.h27iuc5j5o.astroid@naverao1-tp.none>
 <87lgqv4ni9.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 20 Apr 2017 16:11:10 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > Excerpts from Masami Hiramatsu's message of April 19, 2017 20:13:
> >> 
> >> BTW, as I pointed, 5/7 and 6/7 should be merged since this actually
> >> makes meaningful change.
> >
> > Yes, sorry if I wasn't clear in my previous reply in the (!) previous 
> > patch series.
> >
> > Since this has to go through the powerpc tree, I followed this since I 
> > felt that Michael Ellerman prefers to keep functional changes separate 
> > from refactoring. I'm fine with either approach.
> >
> > Michael?
> 
> Yeah I'd definitely like this to be two patches. Otherwise when reading
> the combined diff it's much harder to see the change.

OK, let it be so.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
