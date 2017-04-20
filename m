Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7pQl1rS9zDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 16:11:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 6/7] powerpc: kprobes: emulate instructions on kprobe
 handler re-entry
In-Reply-To: <1492620027.h27iuc5j5o.astroid@naverao1-tp.none>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <0d4193a90e4b2ad3cd2ef33d41228b80a2ac9f91.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170419234319.7893df9c158e565fede4a386@kernel.org>
 <1492620027.h27iuc5j5o.astroid@naverao1-tp.none>
Date: Thu, 20 Apr 2017 16:11:10 +1000
Message-ID: <87lgqv4ni9.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Excerpts from Masami Hiramatsu's message of April 19, 2017 20:13:
>> 
>> BTW, as I pointed, 5/7 and 6/7 should be merged since this actually
>> makes meaningful change.
>
> Yes, sorry if I wasn't clear in my previous reply in the (!) previous 
> patch series.
>
> Since this has to go through the powerpc tree, I followed this since I 
> felt that Michael Ellerman prefers to keep functional changes separate 
> from refactoring. I'm fine with either approach.
>
> Michael?

Yeah I'd definitely like this to be two patches. Otherwise when reading
the combined diff it's much harder to see the change.

cheers
