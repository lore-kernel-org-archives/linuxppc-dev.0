Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4616D475.5090602@am.sony.com>
Date: Fri, 06 Apr 2007 16:15:01 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
References: <1175208237.3122.78.camel@pmac.infradead.org>	
	<4616BA1A.3090309@am.sony.com>	
	<1175898852.7407.11.camel@localhost.localdomain>
	<1175899398.2764.68.camel@shinybook.infradead.org>
In-Reply-To: <1175899398.2764.68.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> On Sat, 2007-04-07 at 08:34 +1000, Benjamin Herrenschmidt wrote:
>> A bit yukcy but I suppose it'll do for now ... though this shouldn't
>> be kept as a long term approach unless there's some versionning or
>> such. You also need to pull the initrd btw. 
> 
> I really don't think we should be doing it like that in the kernel
> proper. Provide a DT blob in the bootwrapper by all means, but there's
> no real need to override the device-tree like that when all we really
> need to do is refrain from crashing when there's memory listed in the
> device-tree.
> 
> If we're going to avoid hacking kexec userspace tools, we _want_ the RMO
> memory listed in the device-tree anyway. But we can fix that up for
> ourselves rather than overriding the whole device-tree, surely?
> 

Its just a short term hack.

-Geoff
