Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17719.64246.555371.701194@cargo.ozlabs.ibm.com>
Date: Fri, 20 Oct 2006 08:23:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Lameter writes:

> Could you confirm that there is indeed no memory on node 0? 

There is about a gigabyte of memory on node 0.

> The expectation to have memory available on the node that you 
> bootstrap on is not unrealistic.

What exactly does "available" mean in this context?  The console log I
posted earlier showed node 0 as having an active PFN range of 32768 -
278528 (245760 pages, or 960MB), and then showed a "freeing bootmem
node 0" message, *before* we hit the BUG.

If "available" doesn't mean "there are active pages which have been
given to the VM system via free_all_bootmem_node()", what does it
mean?

Paul.
