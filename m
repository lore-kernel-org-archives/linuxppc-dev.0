Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55E2DB7DA2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 00:19:32 +1100 (EST)
Subject: Re: [PATCHv4 2/2] powerpc: implement arch_scale_smt_power for Power7
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1266499023.26719.597.camel@laptop>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<1264548495.12239.56.camel@jschopp-laptop>
	<1264720855.9660.22.camel@jschopp-laptop>
	<1264721088.10385.1.camel@jschopp-laptop>
	<1265403478.6089.41.camel@jschopp-laptop>
	<1266142340.5273.418.camel@laptop>  <25851.1266445258@neuling.org>
	<1266499023.26719.597.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Feb 2010 14:19:19 +0100
Message-ID: <1266499159.26719.605.camel@laptop>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-02-18 at 14:17 +0100, Peter Zijlstra wrote:
> 
> There's one fundamental assumption, and one weakness in the
> implementation.
> 
Aside from bugs and the like.. ;-)
