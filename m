Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0960BB6FBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 20:08:14 +1000 (EST)
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1299766211.2308.4468.camel@twins>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins> <1299675674.2308.2924.camel@twins>
	<1299766211.2308.4468.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Apr 2011 12:07:36 +0200
Message-ID: <1303294056.8345.122.camel@twins>
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

On Thu, 2011-03-10 at 15:10 +0100, Peter Zijlstra wrote:
>=20
> Also, still waiting to hear from the Power7 folks on how often they
> think to rebuild the topology and how they think that makes sense,
> afaict Power7 does have actual NUMA nodes unlike s390, so I'm still not
> seeing how that's going to work properly at all.=20

Jesse care to answer? I hear from Ben you're responsible for that mess.
