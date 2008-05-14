Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE800DDF15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 06:32:57 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4EKTgIL017755
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 16:29:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4EKWsX3096444
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 14:32:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4EKWqtB024271
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 14:32:53 -0600
Date: Wed, 14 May 2008 13:32:51 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [BUG] 2.6.26-rc2-mm1 - kernel panic at inet_create() on powerpc
Message-ID: <20080514203251.GF8812@linux.vnet.ibm.com>
References: <20080514010129.4f672378.akpm@linux-foundation.org>
	<482B066F.4010605@linux.vnet.ibm.com>
	<20080514160705.GB8812@linux.vnet.ibm.com>
	<20080514200546.GA4802@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080514200546.GA4802@martell.zuzino.mipt.ru>
Cc: linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, davem@davemloft.net,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 15, 2008 at 12:05:46AM +0400, Alexey Dobriyan wrote:
> On Wed, May 14, 2008 at 09:07:05AM -0700, Paul E. McKenney wrote:
> > On Wed, May 14, 2008 at 09:04:07PM +0530, Kamalesh Babulal wrote:
> > > Hi Andrew,
> > > 
> > > 2.6.26-rc2-mm1 kernel panics on powerpc, while running ltp test over it.
> > > I have attached the gdb output of the pc and lr registers. The patch
> > > list_for_each_rcu-must-die-networking.patch points to changes made 
> > > to the same lines listed by the gdb output.
> > 
> > Hmmm....  Does the panic go away when this patch is reverted?
> 
> Yes.

OK, am awake now, apologies for my confusion.  Not sure -what- state
I was in when generating and validating the original...

							Thanx, Paul
