Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 7979EB7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  9 Aug 2009 23:55:30 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Date: Sun, 9 Aug 2009 15:22:02 +0200
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090809120818.GA1338@ucw.cz>
In-Reply-To: <20090809120818.GA1338@ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200908091522.02898.rjw@sisk.pl>
Cc: "Brown, Len" <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Shaohua Li <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 09 August 2009, Pavel Machek wrote:
> Hi!
> 
> > > Also, approaches such as [1] can make use of this
> > > extended infrastructure instead of putting the CPU to an arbitrary C-state
> > > when it is offlined, thereby providing the system administrator a rope to hang
> > > himself with should he feel the need to do so.
> > I didn't see the reason why administrator needs to know which state offline cpu
> > should stay. Don't know about powerpc side, but in x86 side, it appears deepest
> > C-state is already preferred.
> > 
> 
> Agreed, deepest c-state is always best, there's no need to make it configurable.

Unless it doesn't work.

Rafael
