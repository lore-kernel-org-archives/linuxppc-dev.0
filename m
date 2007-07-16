Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2C898DDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:55:28 +1000 (EST)
Date: Mon, 16 Jul 2007 14:55:30 -0700 (PDT)
Message-Id: <20070716.145530.51840998.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [PATCH] crash in 2.6.22-git2 sysctl_set_parent()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070716172535.GB5771@austin.ibm.com>
References: <20070713200515.GS5549@austin.ibm.com>
	<20070713.154702.17863636.davem@davemloft.net>
	<20070716172535.GB5771@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, ebiederm@xmission.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Mon, 16 Jul 2007 12:25:35 -0500

> On Fri, Jul 13, 2007 at 03:47:02PM -0700, David Miller wrote:
> > From: linas@austin.ibm.com (Linas Vepstas)
> > Date: Fri, 13 Jul 2007 15:05:15 -0500
> > 
> > > 
> > > This is a patch (& bug report) for a crash in sysctl_set_parent() 
> > > in 2.6.22-git2. 
> > > 
> > > Problem: 2.6.22-git2 crashes with a stack trace 
> > > 
> > > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> > 
> > Thanks for tracking this down, I'll apply your patch.
> 
> NAK. As I just explained in another email, this bug
> was introduced by the "send-to-self" patch I habitually
> apply -- so habitually, that I forgot I was not working 
> with a "clean" tree. So it goes ... 

I saw all of this, thanks.
