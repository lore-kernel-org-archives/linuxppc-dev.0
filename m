Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 012FF67B58
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 19:11:46 +1000 (EST)
Date: Fri, 7 Jul 2006 02:11:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: G5 troubles booting powerpc-git (July 6)
Message-Id: <20060707021137.7f5dd182.akpm@osdl.org>
In-Reply-To: <1152262667.9862.64.camel@localhost.localdomain>
References: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
	<1152226587.9862.19.camel@localhost.localdomain>
	<20060707012330.f1dea5ac.akpm@osdl.org>
	<1152260824.9862.57.camel@localhost.localdomain>
	<20060707015237.68c768f2.akpm@osdl.org>
	<1152262667.9862.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 07 Jul 2006 18:57:47 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> In the meantime, try on your quad using a g5_defconfig

I tried it with your recently-sent patch applied.  It still dies in
smu_sensors_init().
