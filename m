Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F476B7D2B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 14:11:16 +1000 (EST)
Subject: Re: [patch 1/1] powerpc: add rcu_read_lock() to gup_fast()
	implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20100428032931.GE5683@laptop>
References: <201004272110.o3RLAl7P019943@imap1.linux-foundation.org>
	<20100428032931.GE5683@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 14:10:58 +1000
Message-ID: <1272427858.24542.60.camel@pasglop>
Mime-Version: 1.0
Cc: riel@redhat.com, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-28 at 13:29 +1000, Nick Piggin wrote:
> I think I nacked this because the rest of the powerpc code also
> assumes irq disables provide an rcu critical section. The plan was
> to convert powerpc pagetable code to use call_rcu_sched.

Right, on my todo list.

Cheers,
Ben.
