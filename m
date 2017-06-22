Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtw5d3HHvzDqlZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 07:41:57 +1000 (AEST)
Date: Thu, 22 Jun 2017 23:41:51 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, John Allen <jallen@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc: Only obtain cpu_hotplug_lock if called by rtasd
In-Reply-To: <878tkjn7uo.fsf@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1706222340280.2221@nanos>
References: <1497996510-4032-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8737attzw5.fsf@concordia.ellerman.id.au> <87h8z8g6wu.fsf@linux.vnet.ibm.com>
 <87r2ycqigf.fsf@concordia.ellerman.id.au> <878tkjn7uo.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jun 2017, Thiago Jung Bauermann wrote:
> Michael Bringmann provided this information:
> >> It's not hard to backport both this patch and commit fe5595c07400
> >> ("stop_machine: Provide stop_machine_cpuslocked()") from branch
> >> smp/hotplug in tip.git for stable.
> >
> > Yeah but it's not really my business backporting that unfortunately.
> 
> Sorry, I wasn't clear. I was offering to provide backported patches for
> the relevant stable branches.
> 
> Though that will only be necessary if we also backport the topology
> fixes as well.

So shall I pick up the fix and route it through tip smp/hotplug where the
cpu hotplug core changes reside on which that patch depends on?

Thanks,

	tglx
