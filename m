Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03F96DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 22:54:11 +1100 (EST)
Date: Thu, 19 Mar 2009 12:53:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: linux-next: cpus4096 tree build failure
Message-ID: <20090319115342.GA22905@elte.hu>
References: <20090319215300.1833d28e.sfr@canb.auug.org.au>
	<200903192137.15209.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200903192137.15209.rusty@rustcorp.com.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Thursday 19 March 2009 21:23:00 Stephen Rothwell wrote:
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Thu, 19 Mar 2009 21:35:24 +1100
> > Subject: [PATCH] powerpc: mmzone.h needs cpumask_t to be defined
> > 
> > Commit 082edb7bf443eb8eda15b482d16ad9dd8137ad24 ("numa,cpumask: move
> > numa_node_id default implementation to topology.h") removed the include
> > of linux/topology.h from linux/mmzone.h which exposed this lack.
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Ingo, please apply.
> 
> Apparently sparc is similarly broken :(

I've applied it.

( I cannot push it to the auto-cpus4096-next branch yet because you
  broke the scheduler as well (boot crash) so the topic is marked
  broken. )

	Ingo
