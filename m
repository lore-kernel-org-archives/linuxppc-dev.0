Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26D45B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 09:07:15 +1100 (EST)
Subject: Re: Can't boot benh/powerpc.git kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jim Keniston <jkenisto@linux.vnet.ibm.com>
In-Reply-To: <1289418856.2983.23.camel@localhost>
References: <1289418856.2983.23.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Nov 2010 09:06:57 +1100
Message-ID: <1289426817.2147.1403.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-11-10 at 11:54 -0800, Jim Keniston wrote:
> I got Ben's linux/kernel/git/benh/powerpc.git source and built it
> (.config file attached*).  It hangs on boot.  When I boot it with
> loglevel=8, its last words are:

First, please try with Linus upstream. The "master" branch in my git
tree is quite stale, and my next and merge branch are too at the moment
as I'm still travelling. All our current stuff was merged during the
last merge window so there's nothing "new" for you to pickup in my tree
at the moment :-)

If the problem still occurs, I'll have a look next week.

Cheers,
Ben.

> ...
> Security Framework initialized
> SELinux:  Disabled at boot.
> Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
> Mount-cache hash table entries: 4096
> Initializing cgroup subsys ns
> Initializing cgroup subsys cpuacct
> Initializing cgroup subsys memory
> Initializing cgroup subsys devices
> Initializing cgroup subsys freezer
> irq: irq 2 on host null mapped to virtual irq 16
> 
> ... and then it hangs.
> 
> The whole console log is attached.
> 
> Any suggestions?
> 
> This is on a Power 5 system -- model = IBM,9111-520.
> 
> *I earlier tried booting it with the following options enabled, with the
> same result before and after I backed them off.
> CONFIG_PREEMPT
> CONFIG_DEBUG_PREEMPT
> CONFIG_DEBUG_SLAB
> CONFIG_DEBUG_PAGEALLOC
> CONFIG_DEBUG_MUTEXES
> CONFIG_DEBUG_SPINLOCK
> CONFIG_DEBUG_SPINLOCK_SLEEP
> 
> Thanks.
> Jim Keniston
> LTC - Beaverton, OR
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
