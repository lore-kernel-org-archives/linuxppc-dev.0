Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/6] powerpc: make irq_{alloc, free}_virt private and
	remove count argument
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20110504155905.GB3317@ponder.secretlab.ca>
References: <20110428192227.8979.49181.stgit@ponder>
	<20110428200153.8979.23873.stgit@ponder>
	<1304387267.2513.298.camel@pasglop>
	<20110504155905.GB3317@ponder.secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 May 2011 10:39:55 +1000
Message-ID: <1304555995.2513.391.camel@pasglop>
Mime-Version: 1.0
Cc: Michal Simek <monstr@monstr.eu>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, hpa@zytor.com,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-04 at 09:59 -0600, Grant Likely wrote:
> 
> Heh, I wondered about that, but there hasn't been any users for at
> least 5 years (as evidenced by commit e12514650b, "Fix loop logic in
> irq_alloc_virt()") so it was looking pretty dead, and it made the
> patch to switch to using irq_alloc_desc*() quite a bit simpler if it
> was removed.  :-)
> 
> I'm not particularly attached to this patch, so I can drop it from the
> series. 

Well, Willy recently added support for the MSI block allocation so ...

Cheers,
Ben.
