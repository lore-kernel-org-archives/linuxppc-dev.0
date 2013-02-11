Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8F702C02CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 06:34:59 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 14:34:56 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 88CA96E9901
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 14:18:17 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1BJIHUG136906
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 14:18:17 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1BJHvww018627
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 12:17:59 -0700
Date: Mon, 11 Feb 2013 11:08:52 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 00/45] CPU hotplug: stop_machine()-free CPU hotplug
Message-ID: <20130211190852.GA5695@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <510FBC01.2030405@linux.vnet.ibm.com>
 <87haloiwv0.fsf@rustcorp.com.au>
 <51134596.4080106@linux.vnet.ibm.com>
 <20130208154113.GV17833@n2100.arm.linux.org.uk>
 <51152B81.2050501@linux.vnet.ibm.com>
 <51153F72.1060005@linux.vnet.ibm.com>
 <CAKfTPtCe+cD7LLkb+D6pqG1SwG2V08ws=4XO3ttHEHV2qgmqPg@mail.gmail.com>
 <5118E2CD.90401@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5118E2CD.90401@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, rostedt@goodmis.org, rjw@sisk.pl,
 namhyung@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, oleg@redhat.com,
 Vincent Guittot <vincent.guittot@linaro.org>, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2013 at 05:53:41PM +0530, Srivatsa S. Bhat wrote:
> On 02/11/2013 05:28 PM, Vincent Guittot wrote:
> > On 8 February 2013 19:09, Srivatsa S. Bhat
> > <srivatsa.bhat@linux.vnet.ibm.com> wrote:

[ . . . ]

> >> Adding Vincent to CC, who had previously evaluated the performance and
> >> latency implications of CPU hotplug on ARM platforms, IIRC.
> >>
> >
> > Hi Srivatsa,
> > 
> > I can try to run some of our stress tests on your patches.
> 
> Great!
> 
> > Have you
> > got a git tree that i can pull ?
> > 
> 
> Unfortunately, no, none at the moment..  :-(

You do need to create an externally visible git tree.  In the meantime,
I have added your series at rcu/bhat.2013.01.21a on -rcu:

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

This should appear soon on a kernel.org mirror near you.  ;-)

							Thanx, Paul
