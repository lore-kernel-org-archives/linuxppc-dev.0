Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9B2FDE227
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 03:25:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6GHPbCE014739
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 13:25:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6GHPako112940
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 11:25:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6GHPZBh025008
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 11:25:35 -0600
Date: Mon, 16 Jul 2007 12:25:35 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] crash in 2.6.22-git2 sysctl_set_parent()
Message-ID: <20070716172535.GB5771@austin.ibm.com>
References: <20070713200515.GS5549@austin.ibm.com>
	<20070713.154702.17863636.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070713.154702.17863636.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
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

On Fri, Jul 13, 2007 at 03:47:02PM -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> Date: Fri, 13 Jul 2007 15:05:15 -0500
> 
> > 
> > This is a patch (& bug report) for a crash in sysctl_set_parent() 
> > in 2.6.22-git2. 
> > 
> > Problem: 2.6.22-git2 crashes with a stack trace 
> > 
> > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> Thanks for tracking this down, I'll apply your patch.

NAK. As I just explained in another email, this bug
was introduced by the "send-to-self" patch I habitually
apply -- so habitually, that I forgot I was not working 
with a "clean" tree. So it goes ... 

--linas
