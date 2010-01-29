Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3260DB7D33
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 13:02:56 +1100 (EST)
Subject: Re: [PATCHv2 2/2] powerpc: implement arch_scale_smt_power for Power7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <4B621213.2010805@austin.ibm.com>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<1264548495.12239.56.camel@jschopp-laptop>
	<1264553577.3601.144.camel@pasglop> <4B621213.2010805@austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Jan 2010 12:23:44 +1100
Message-ID: <1264728224.20211.35.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> I've tested it with manually offlined threads and it behaves as I'd like 
> it to.

Which is ? IE. I'm happy that you like how it behaves, but I'd like to u
understand how that is so I can make sure I'm also happy with it :-)

Cheers,
Ben.
