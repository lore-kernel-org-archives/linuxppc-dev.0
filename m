Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1CDAD2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 02:42:53 +1100 (EST)
Date: Fri, 8 Feb 2013 15:41:13 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 00/45] CPU hotplug: stop_machine()-free CPU hotplug
Message-ID: <20130208154113.GV17833@n2100.arm.linux.org.uk>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <510FBC01.2030405@linux.vnet.ibm.com> <87haloiwv0.fsf@rustcorp.com.au>
 <51134596.4080106@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51134596.4080106@linux.vnet.ibm.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, rostedt@goodmis.org, rjw@sisk.pl,
 namhyung@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 07, 2013 at 11:41:34AM +0530, Srivatsa S. Bhat wrote:
> On 02/07/2013 09:44 AM, Rusty Russell wrote:
> > "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
> >> On 01/22/2013 01:03 PM, Srivatsa S. Bhat wrote:
> >>                  Avg. latency of 1 CPU offline (ms) [stop-cpu/stop-m/c latency]
> >>
> >> # online CPUs    Mainline (with stop-m/c)       This patchset (no stop-m/c)
> >>
> >>       8                 17.04                          7.73
> >>
> >>      16                 18.05                          6.44
> >>
> >>      32                 17.31                          7.39
> >>
> >>      64                 32.40                          9.28
> >>
> >>     128                 98.23                          7.35
> > 
> > Nice!
> 
> Thank you :-)
> 
> >  I wonder how the ARM guys feel with their quad-cpu systems...
> > 
> 
> That would be definitely interesting to know :-)

That depends what exactly you'd like tested (and how) and whether you'd
like it to be a test-chip based quad core, or an OMAP dual-core SoC.
