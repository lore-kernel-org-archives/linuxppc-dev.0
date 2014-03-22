Return-Path: <davidlohr@hp.com>
Received: from g4t3425.houston.hp.com (g4t3425.houston.hp.com [15.201.208.53])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 313162C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Mar 2014 14:36:37 +1100 (EST)
Message-ID: <1395459391.2546.8.camel@buesod1.americas.hpqcorp.net>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Davidlohr Bueso <davidlohr@hp.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 20:36:31 -0700
In-Reply-To: <20140322022754.GA21677@linux.vnet.ibm.com>
References: <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFwH2sJKCH6hUf8H-7nMPo8YwFCR6oP8McZ5VpMcGDrYSw@mail.gmail.com>
 <1395342510.14694.43.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFw8wSe-DUtZ8=rjFJzXYmOSsZ0JzS-_jsZKrDai8LZMXw@mail.gmail.com>
 <1395346808.14694.62.camel@buesod1.americas.hpqcorp.net>
 <20140321045501.GD30295@linux.vnet.ibm.com>
 <CA+55aFyX0sj_MjTas3RYWWOa1W-xc3t0Af_0vdmsmgui8Apqpw@mail.gmail.com>
 <20140322022754.GA21677@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-03-22 at 07:57 +0530, Srikar Dronamraju wrote:
> > > So reverting and applying v3 3/4 and 4/4 patches works for me.
> > 
> > Ok, I verified that the above endds up resulting in the same tree as
> > the minimal patch I sent out, modulo (a) some comments and (b) an
> > #ifdef CONFIG_SMP in futex_get_mm() that doesn't really matter.
> > 
> > So I committed the minimal patch with your tested-by.
> > 
> 
> Just to be sure, I have verified with latest mainline with HEAD having
> commit 08edb33c4 (Merge branch 'drm-fixes' of
> git://people.freedesktop.org/~airlied/linux) which also has the commit
> 11d4616bd0 futex:( revert back to the explicit waiter counting code).

Thanks for double checking.
