Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4BE88B7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 18:18:47 +1100 (EST)
Date: Wed, 14 Oct 2009 09:18:38 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
Message-ID: <20091014071838.GE23248@one.firstfloor.org>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
	<20091008104249.GJ20595@linux.vnet.ibm.com>
	<1254999033.26976.272.camel@twins>
	<8763akh4re.fsf@basil.nowhere.org>
	<20091014061727.GA8605@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091014061727.GA8605@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> How about something like this..
> If the arch does not enable CONFIG_CPU_IDLE, the cpuidle_idle_call
> which is called from cpu_idle() should call default_idle without
> involving the registering cpuidle steps. This should prevent bloating
> up of the kernel for archs which dont want to use cpuidle.

On x86 some people want small kernel too, so selecting it on a architecture
granuality is not good. Also you can make it default, you just need
to slim it down first.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
