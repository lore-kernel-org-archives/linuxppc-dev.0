Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 29 Apr 2011 11:43:55 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/6] General device tree irq domain infrastructure
Message-ID: <20110429174355.GA21098@ponder.secretlab.ca>
References: <20110428192227.8979.49181.stgit@ponder>
	<4DBAE461.7000307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DBAE461.7000307@linutronix.de>
Cc: Michal Simek <monstr@monstr.eu>, devicetree-discuss@lists.ozlabs.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, hpa@zytor.com,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 29, 2011 at 06:16:33PM +0200, Sebastian Andrzej Siewior wrote:
> Grant Likely wrote:
> >I'd really like to get patches 1-4 merged into 2.6.40.  Please test.
> >I'm also running through build testing here, and when it's complete
> >I'll push it out to a 'devicetree/irq-domain' branch on
> >git://git.secretlab.ca/git/linux-2.6
> 
> I pulled this, built and booted my x86-dt box and nothing exploded so far.
> 
> If you merge Linus' tree then you will get a conflict (sooner or later) in
> ioapic_of_irq_map() in arch/x86/kernel/devicetree.c:
> 
> -       return io_apic_setup_irq_pin_once(*out_hwirq, cpu_to_node(0), &attr);
>  -      if (io_apic_setup_irq_pin(hwirq, cpu_to_node(0), &attr))
> ++      if (io_apic_setup_irq_pin_once(hwirq, cpu_to_node(0), &attr))
> 
> Sebastian

Thanks Sebastian.  Unless you say otherwise, I'll take that as an Acked-by.  :-)

g.
