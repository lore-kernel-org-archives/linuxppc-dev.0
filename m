Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CEB1CB6F2B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 18:07:33 +1100 (EST)
Subject: Re: [PATCH -tip tracing/kprobes] PPC: Powerpc port of the
	kprobe-based event tracer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <13884.1261016575@neuling.org>
References: <20091216043619.963539987@mars.in.ibm.com>
	<20091216043933.GA9328@in.ibm.com>  <13884.1261016575@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Dec 2009 18:07:07 +1100
Message-ID: <1261033627.6682.28.camel@pasglop>
Mime-Version: 1.0
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@redhat.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-17 at 13:22 +1100, Michael Neuling wrote:

> > + * The @offset is the offset of the register in struct pt_regs.
> > + * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
> > + */
> > +static inline unsigned long regs_get_register(struct pt_regs *regs,
> > +						unsigned int offset)
> 
> Please put only function definitions in the .h file.  The rest of this
> should be in .c

Not really in that case actually. There are just simple accessors, we
traditionally have them in .h files so they get fully inlined when
used.

I'll have a look at the rest of the patch asap, hopefully tomorrow.

Cheers,
Ben.
