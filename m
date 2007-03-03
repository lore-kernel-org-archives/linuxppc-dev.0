Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0384BDDF90
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 19:28:45 +1100 (EST)
Subject: Re: [PATCH] ehea: Optional TX/RX path optimized for SMP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <andi@firstfloor.org>
In-Reply-To: <p73mz2vauvz.fsf@bingen.suse.de>
References: <200702231730.58579.ossthema@de.ibm.com>
	<p73mz2vauvz.fsf@bingen.suse.de>
Content-Type: text/plain
Date: Sat, 03 Mar 2007 09:28:28 +0100
Message-Id: <1172910508.8184.53.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
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

On Sat, 2007-03-03 at 04:06 +0100, Andi Kleen wrote:
> Jan-Bernd Themann <ossthema@de.ibm.com> writes:
> > 
> > Are there any concerns about this approach?
> 
> Yes. You should fix the NAPI code instead of trying to work
> around it.

NAPI is being fixed but the fix will take time to get in. In the
meantime, the solution to get something working is the workaround.

Ben.
