Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A842EDDE9F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 23:52:06 +1100 (EST)
Date: Wed, 1 Apr 2009 14:51:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: tracing/powerpc tree build failure
Message-ID: <20090401125148.GL12966@elte.hu>
References: <20090327230834.93d0221d.sfr@canb.auug.org.au>
	<1238158131.22033.10.camel@localhost.localdomain>
	<20090331165430.383fe51d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090331165430.383fe51d.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> This patch is now applicable to the tracing tree after merging 
> with Linus' tree.

Thanks, that's useful info.

There's the skb tracepoints related merge fixlet needed too. 
Anything else in this context you are aware of?

	Ingo
