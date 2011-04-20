Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F857B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Apr 2011 08:01:38 +1000 (EST)
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1303294056.8345.122.camel@twins>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins> <1299675674.2308.2924.camel@twins>
	<1299766211.2308.4468.camel@twins>  <1303294056.8345.122.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Apr 2011 08:01:09 +1000
Message-ID: <1303336869.2513.26.camel@pasglop>
Mime-Version: 1.0
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-04-20 at 12:07 +0200, Peter Zijlstra wrote:
> On Thu, 2011-03-10 at 15:10 +0100, Peter Zijlstra wrote:
> > 
> > Also, still waiting to hear from the Power7 folks on how often they
> > think to rebuild the topology and how they think that makes sense,
> > afaict Power7 does have actual NUMA nodes unlike s390, so I'm still not
> > seeing how that's going to work properly at all. 
> 
> Jesse care to answer? I hear from Ben you're responsible for that mess.

"responsible for this mess" is a big word :-)

But he's the one to last play with that code ... Jesse ?

Cheers,
Ben.
