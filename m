Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9484B6F5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 22:14:27 +1000 (EST)
Date: Fri, 1 Jul 2011 14:14:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] mm: Move definition of MIN_MEMORY_BLOCK_SIZE to a
	header
Message-ID: <20110701121408.GC28008@elte.hu>
References: <1308013070.2874.784.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308013070.2874.784.camel@pasglop>
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


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> The macro MIN_MEMORY_BLOCK_SIZE is currently defined twice in two .c
> files, and I need it in a third one to fix a powerpc bug, so let's
> first move it into a header
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Ingo, Thomas: Who needs to ack the x86 bit ? I'd like to send that
> to Linus asap with the powerpc fix.

Acked-by: Ingo Molnar <mingo@elte.hu>

(btw., you can consider obvious cleanups as being implicitly acked by 
me and don't need to block fixes on me.)

Thanks,

	Ingo
