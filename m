Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AFE2B6F5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 09:11:32 +1000 (EST)
Subject: Re: [PATCH 1/2] mm: Move definition of MIN_MEMORY_BLOCK_SIZE to a
	header
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20110701121408.GC28008@elte.hu>
References: <1308013070.2874.784.camel@pasglop>
	<20110701121408.GC28008@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 02 Jul 2011 09:11:06 +1000
Message-ID: <1309561866.14501.254.camel@pasglop>
Mime-Version: 1.0
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-01 at 14:14 +0200, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > The macro MIN_MEMORY_BLOCK_SIZE is currently defined twice in two .c
> > files, and I need it in a third one to fix a powerpc bug, so let's
> > first move it into a header
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > Ingo, Thomas: Who needs to ack the x86 bit ? I'd like to send that
> > to Linus asap with the powerpc fix.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> (btw., you can consider obvious cleanups as being implicitly acked by 
> me and don't need to block fixes on me.)

Ok thanks !

Cheers,
Ben.
