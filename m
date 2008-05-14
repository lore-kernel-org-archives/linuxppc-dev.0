Return-Path: <adobriyan@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by ozlabs.org (Postfix) with ESMTP id 1B59BDDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 05:10:18 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id g7so28212muf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 12:10:16 -0700 (PDT)
Date: Thu, 15 May 2008 00:05:46 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.26-rc2-mm1 - kernel panic at inet_create() on powerpc
Message-ID: <20080514200546.GA4802@martell.zuzino.mipt.ru>
References: <20080514010129.4f672378.akpm@linux-foundation.org>
	<482B066F.4010605@linux.vnet.ibm.com>
	<20080514160705.GB8812@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080514160705.GB8812@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, davem@davemloft.net,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 14, 2008 at 09:07:05AM -0700, Paul E. McKenney wrote:
> On Wed, May 14, 2008 at 09:04:07PM +0530, Kamalesh Babulal wrote:
> > Hi Andrew,
> > 
> > 2.6.26-rc2-mm1 kernel panics on powerpc, while running ltp test over it.
> > I have attached the gdb output of the pc and lr registers. The patch
> > list_for_each_rcu-must-die-networking.patch points to changes made 
> > to the same lines listed by the gdb output.
> 
> Hmmm....  Does the panic go away when this patch is reverted?

Yes.
