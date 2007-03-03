Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	by ozlabs.org (Postfix) with ESMTP id 7F2FDDDF88
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 00:02:20 +1100 (EST)
Date: Sat, 3 Mar 2007 13:33:40 +0100
From: Andi Kleen <andi@firstfloor.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ehea: Optional TX/RX path optimized for SMP
Message-ID: <20070303123340.GB5357@one.firstfloor.org>
References: <200702231730.58579.ossthema@de.ibm.com>
	<p73mz2vauvz.fsf@bingen.suse.de>
	<1172910508.8184.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1172910508.8184.53.camel@localhost.localdomain>
Cc: Thomas Klein <tklein@de.ibm.com>, Andi Kleen <andi@firstfloor.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 03, 2007 at 09:28:28AM +0100, Benjamin Herrenschmidt wrote:
> On Sat, 2007-03-03 at 04:06 +0100, Andi Kleen wrote:
> > Jan-Bernd Themann <ossthema@de.ibm.com> writes:
> > > 
> > > Are there any concerns about this approach?
> > 
> > Yes. You should fix the NAPI code instead of trying to work
> > around it.
> 
> NAPI is being fixed but the fix will take time to get in. In the
> meantime, the solution to get something working is the workaround

If it works right now with just a little less efficiency there
is no pressing need to do workarounds until the real solution.

Besides I doubt that patch would have made .21 anyways and in .22
you might already have multiqueue NAPI.

-Andi
