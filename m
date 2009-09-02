Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A87A4B7C0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 15:53:57 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACFB3DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 15:53:56 +1000 (EST)
Subject: Re: [PATCH] Fix fake numa on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ankita Garg <ankita@in.ibm.com>
In-Reply-To: <20090902053653.GA3806@in.ibm.com>
References: <20090901050316.GA4076@in.ibm.com>
	<20090901055753.GB5563@balbir.in.ibm.com>
	<20090901092407.GC4076@in.ibm.com>
	<20090901142729.GA5022@balbir.in.ibm.com>
	<20090902053653.GA3806@in.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 15:53:43 +1000
Message-Id: <1251870823.14675.420.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-02 at 11:06 +0530, Ankita Garg wrote:
> > Oh! interesting.. cpuless nodes :) I think we need to fix this in the
> > longer run and distribute cpus between fake numa nodes of a real node
> > using some acceptable heuristic.
> >
> 
> True. Presently this is broken on both x86 and ppc systems. It would be
> interesting to find a way to map, for example, 4 cpus to >4 number of
> fake nodes created from a single real numa node!

Since I'm pretty sure there could be CPU less nodes just like there
could be memory-less nodes, it would be good if fake numa could
simulate them too :-)

Cheers,
Ben.
