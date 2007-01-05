Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DD22CDDE0C
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jan 2007 08:15:40 +1100 (EST)
Date: Fri, 5 Jan 2007 13:15:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.20-rc3-mm1
Message-Id: <20070105131516.bd9d8f45.akpm@osdl.org>
In-Reply-To: <1168030536.22458.28.camel@localhost.localdomain>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	<200701051723.08112.m.kozlowski@tuxland.pl>
	<1168030536.22458.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 06 Jan 2007 07:55:36 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2007-01-05 at 17:23 +0100, Mariusz Kozlowski wrote:
> > Hello, 
> > 
> > 	Doesn't build on my iMac G3 based garage jukebox ;-)
> > 
> > arch/powerpc/kernel/of_platform.c:479: error: unknown field 'multithread_probe' specified in initializer
> > arch/powerpc/kernel/of_platform.c:479: warning: initialization makes pointer from integer without a cast
> > make[1]: *** [arch/powerpc/kernel/of_platform.o] Blad 1
> > make: *** [arch/powerpc/kernel] Blad 2
> > 
> > I guess someone who knows multithread code should take a look at it.
> 
> Hrm. struct driver -> multithread_probe is gone in -mm ?
> 

yeah, it moved into struct bus_type.

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/broken-out/driver-core-per-subsystem-multithreaded-probing.patch
