Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99404B7CCD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 15:27:18 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc: implement arch_scale_smt_power for Power7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <4B5DD9F1.2010002@austin.ibm.com>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<26556.1264021443@neuling.org>
	<4B577F1A.9060907@austin.ibm.com> <1264302028.3601.36.camel@pasglop>
	<4B5DD9F1.2010002@austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 26 Jan 2010 15:23:56 +1100
Message-ID: <1264479836.3601.113.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, ego@in.ibm.com,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-01-25 at 11:50 -0600, Joel Schopp wrote:
> > Look at the cputhreads.h implementation ... Today we only support
> > power-of-two numbers of threads.
> >   
> I've run 3 threads using cpu hotplug to offline 1 of the 4.  It's 
> certainly a stupid idea, but there you go. 

Oh, you mean you need to use the actual online count ? In which case,
yes, you do indeed need to be a bit more careful... In this case though,
you're probably better off special casing "3" :-)

Cheers,
Ben.
