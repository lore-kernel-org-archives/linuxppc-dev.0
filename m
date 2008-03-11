Return-Path: <dan.j.williams@intel.com>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip DMA
	engine
From: Dan Williams <dan.j.williams@intel.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <F4B05C0E-99BB-4F60-BDD8-A79F07A81692@kernel.crashing.org>
References: <20080306233900.GA3969@lixom.net>
	<20080311000619.ba39311f.akpm@linux-foundation.org>
	<20080311142545.GA18843@lixom.net>
	<20080311105355.64a9c380.akpm@linux-foundation.org>
	<1205259311.26723.40.camel@dwillia2-linux.ch.intel.com>
	<F4B05C0E-99BB-4F60-BDD8-A79F07A81692@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 13:37:20 -0700
Message-Id: <1205267840.27495.9.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Cc: hskinnemoen@atmel.com, "Nelson, Shannon" <shannon.nelson@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	pasemi-linux@ozlabs.org, Olof Johansson <olof@lixom.net>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-03-11 at 11:29 -0700, Kumar Gala wrote:
> > My fault for not pushing out this cleanup to the old url while the
> > git-md-accel changeover was pending.
> 
> Any reason not to push Zhang's fixes for 2.6.25?

I plan to push these fixes for 2.6.25.  Olof had some valid comments
about "Fix fsldma.c warning messages..." [1].

> I also have a patch I want to push for 2.6.25 to deal with the powerpc 
> device tree.  I was going to handle this via the powerpc tree's since 
> that seems to be the model we have used for netdev and other drivers 
> that play with arch/powerpc.  I hope that's not an issue (I'll CC you 
> on the patch).

Not an issue at all.  Just give me a heads up on what you want me to
pick up and what you want me to just ack.

[1] http://marc.info/?l=linux-kernel&m=120524510630957&w=2
