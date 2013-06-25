Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 721962C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 17:37:50 +1000 (EST)
Message-ID: <1372145785.3944.195.camel@pasglop>
Subject: Re: Regression in RCU subsystem in latest mainline kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 25 Jun 2013 17:36:25 +1000
In-Reply-To: <20130625071914.GA29957@concordia>
References: <1626500.7WAVXjfS9F@pcimr>
 <20130614122800.GL5146@linux.vnet.ibm.com> <1645938.As0LR1yeVd@pcimr>
 <1371243967.9844.338.camel@gandalf.local.home>
 <1371261741.21896.20.camel@pasglop> <20130617074213.GA3589@concordia>
 <20130619040906.GA5146@linux.vnet.ibm.com>
 <20130625071914.GA29957@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rojhalat Ibrahim <imr@rtschenk.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-25 at 17:19 +1000, Michael Ellerman wrote:
> Here's another trace from 3.10-rc7 plus a few local patches.
> 
> We suspect that the perf enable could be causing a flood of
> interrupts, but why
> that's clogging things up so badly who knows.

Additionally, perf being potentially NMIs , we might be hitting a bad
case of reentrance in RCU ... hard to tell.

Cheers,
Ben.
