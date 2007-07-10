Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18068.5829.53635.797336@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jul 2007 09:31:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
In-Reply-To: <78777AB0-8FA2-4FB0-9D02-6504ED28957D@kernel.crashing.org>
References: <135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
	<464C9E67.2020909@ru.mvista.com>
	<6E0D5E13-C939-4FCE-81A3-F29DFA6436A2@kernel.crashing.org>
	<464CA222.8000407@ru.mvista.com> <464D9E7E.3090605@genesi-usa.com>
	<464DADFC.3080802@ru.mvista.com> <464DB800.40702@genesi-usa.com>
	<1179499713.12981.75.camel@chaos>
	<32E780BE-58B7-4303-AA49-1852C4C7EB50@kernel.crashing.org>
	<464DD9DD.8030603@genesi-usa.com> <20070710105212.GA14682@iram.es>
	<78777AB0-8FA2-4FB0-9D02-6504ED28957D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	mingo@elte.hu, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> > This scales with the number of processors since there is one
> > decrementer per core (is it per thread on SMT chips?
> > I don't know).
> 
> One per core.

No, each thread has its own decrementer, but the timebase is shared.

Paul.
