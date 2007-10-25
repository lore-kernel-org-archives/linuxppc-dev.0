Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id B63F8DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 00:18:00 +1000 (EST)
Message-ID: <4720A57C.2080508@semihalf.com>
Date: Thu, 25 Oct 2007 16:17:32 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/11] [POWERPC] Add 'machine: ...' line to
	common	show_cpuinfo()
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>	<20071023231309.29359.20887.stgit@hekate.izotz.org>
	<20071023232303.GA10595@localhost.localdomain>
In-Reply-To: <20071023232303.GA10595@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Oct 24, 2007 at 01:13:09AM +0200, Marian Balakowicz wrote:
>> Print out '/model' property as a machine name in generic
>> show_cpuinfo() routine.
> 
> There's no such thing as /model; subnodes and properties have a
> different namespace, so the root node, /, has a property named
> 'model'.
> 
> Yes, it's clear what you mean in this context, but it's a bad habit to
> get into.

Right, I'll try to make it more clear, thanks for pointing this out.

Cheers,
m.
