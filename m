Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtgkl69MnzDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 22:24:47 +1000 (AEST)
Date: Thu, 22 Jun 2017 14:24:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, John Allen <jallen@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc: Only obtain cpu_hotplug_lock if called by rtasd
In-Reply-To: <87h8z8g6wu.fsf@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1706221423580.1885@nanos>
References: <1497996510-4032-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8737attzw5.fsf@concordia.ellerman.id.au> <87h8z8g6wu.fsf@linux.vnet.ibm.com>
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

On Wed, 21 Jun 2017, Thiago Jung Bauermann wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> >> Notes:
> >>     This patch applies on tip/smp/hotplug, it should probably be carried there.
> >
> > stop_machine_cpuslocked() doesn't exist in mainline so I think it has to
> > be carried there right?
> 
> Yes. I said "probably" because I don't know if you want to wait
> until that branch is merged so that you can carry this patch in your
> tree.

I'll pick it up for 4.12 and you folks can figure out the backporting once
that hits Linus tree.

Thanks,

	tglx
