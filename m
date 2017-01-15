Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1WZr2PXtzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 20:41:08 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id c85so22864988wmi.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 01:41:08 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 15 Jan 2017 10:40:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
 tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
 dhowells@redhat.com, edumazet@google.com, dvhart@linux.intel.com,
 fweisbec@gmail.com, oleg@redhat.com, bobby.prani@gmail.com,
 will.deacon@arm.com, boqun.feng@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH tip/core/rcu 2/3] srcu: Force full grace-period ordering
Message-ID: <20170115094058.GB28621@gmail.com>
References: <20170114091941.GA22961@linux.vnet.ibm.com>
 <1484385601-23379-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170114093550.GB14970@gmail.com>
 <20170114195417.GW5238@linux.vnet.ibm.com>
 <20170114214159.GA7098@linux.vnet.ibm.com>
 <20170115071123.GB26581@gmail.com>
 <20170115074034.GE5238@linux.vnet.ibm.com>
 <20170115075711.GA19506@gmail.com>
 <20170115092454.GF5238@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170115092454.GF5238@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> > [sounds of rummaging around in the Git tree]
> > 
> > I found this commit of yours from ancient history (more than a year ago!):
> > 
> >   commit 12d560f4ea87030667438a169912380be00cea4b
> >   Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >   Date:   Tue Jul 14 18:35:23 2015 -0700
> > 
> >     rcu,locking: Privatize smp_mb__after_unlock_lock()
> >     
> >     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
> >     likely the only thing that ever will use it, so this commit makes this
> >     macro private to RCU.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >     Cc: Will Deacon <will.deacon@arm.com>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> > 
> > So I concur and I'm fine with your patch - or with the status quo code as well.
> 
> I already have the patch queued, so how about I keep it if I get an ack
> from the powerpc guys and drop it otherwise?

Yeah, sounds good! Your patch made me look up 'RelAcq' so it has documentation 
value as well ;-)

Thanks,

	Ingo
