Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1175899398.2764.68.camel@shinybook.infradead.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<4616BA1A.3090309@am.sony.com>
	<1175898852.7407.11.camel@localhost.localdomain>
	<1175899398.2764.68.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Sat, 07 Apr 2007 09:35:07 +1000
Message-Id: <1175902508.7407.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-06 at 18:43 -0400, David Woodhouse wrote:
> On Sat, 2007-04-07 at 08:34 +1000, Benjamin Herrenschmidt wrote:
> > A bit yukcy but I suppose it'll do for now ... though this shouldn't
> > be kept as a long term approach unless there's some versionning or
> > such. You also need to pull the initrd btw. 
> 
> I really don't think we should be doing it like that in the kernel
> proper. Provide a DT blob in the bootwrapper by all means, but there's
> no real need to override the device-tree like that when all we really
> need to do is refrain from crashing when there's memory listed in the
> device-tree.

That's not the only bug of the old device-tree though.

> If we're going to avoid hacking kexec userspace tools, we _want_ the RMO
> memory listed in the device-tree anyway. But we can fix that up for
> ourselves rather than overriding the whole device-tree, surely?
> 
