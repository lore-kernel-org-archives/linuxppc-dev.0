Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D818B704E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2012 06:57:51 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 16 Jun 2012 14:57:46 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2261B19D804C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 20:57:42 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5GKvhkp176604
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 14:57:44 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5GKvgYV001616
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 14:57:43 -0600
Date: Sat, 16 Jun 2012 13:57:38 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 09/10] POWERPC: smp: remove call to
 ipi_call_lock()/ipi_call_unlock()
Message-ID: <20120616205738.GM2420@linux.vnet.ibm.com>
References: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
 <1338275765-3217-10-git-send-email-yong.zhang0@gmail.com>
 <20120616163219.GI2420@linux.vnet.ibm.com>
 <1339867858.15222.12.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339867858.15222.12.camel@twins>
Cc: axboe@kernel.dk, sshtylyov@mvista.com, nikunj@linux.vnet.ibm.com,
 david.daney@cavium.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 akpm@linux-foundation.org, Yong Zhang <yong.zhang0@gmail.com>,
 Paul Mackerras <paulus@samba.org>, srivatsa.bhat@linux.vnet.ibm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 16, 2012 at 07:30:58PM +0200, Peter Zijlstra wrote:
> On Sat, 2012-06-16 at 09:32 -0700, Paul E. McKenney wrote:
> > However, there is an effort to get rid of stop_machine() from the
> > CPU-down path...  So something else will be needed. 
> 
> Elsewhere in this thread I mentioned we could do a synchronize_sched().
> I think that covers most of what stop-machine is doing these days.

Ah, apologies for the noise!

							Thanx, Paul
