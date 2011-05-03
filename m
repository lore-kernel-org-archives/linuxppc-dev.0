Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/6] powerpc: stop exporting irq_map
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20110428200148.8979.66709.stgit@ponder>
References: <20110428192227.8979.49181.stgit@ponder>
	<20110428200148.8979.66709.stgit@ponder>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 May 2011 11:44:21 +1000
Message-ID: <1304387061.2513.294.camel@pasglop>
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

On Thu, 2011-04-28 at 14:01 -0600, Grant Likely wrote:
> First step in eliminating irq_map[] table entirely
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  

Ack in principle, needs scrutiny and testing of course :-)

Cheers,
Ben.
