Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: paulmck@linux.vnet.ibm.com
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH] CELL Oprofile SPU =?iso-8859-1?q?profiling=09updated=09patch?=
Date: Fri, 16 Feb 2007 01:33:13 +0100
References: <1171497138.23691.8.camel@dyn9047021078.beaverton.ibm.com>
	<1171570918.31179.36.camel@dyn9047021078.beaverton.ibm.com>
	<20070215215047.GE1913@linux.vnet.ibm.com>
In-Reply-To: <20070215215047.GE1913@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702160133.14330.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 February 2007 22:50, Paul E. McKenney wrote:
> Is this 1.5ms with interrupts disabled? =A0This time period is problematic
> from a realtime perspective if so -- need to be able to preempt.

No, interrupts should be enabled here. Still, 1.5ms is probably a little
too long without a cond_resched() in case kernel preemption is disabled.

	Arnd <><
