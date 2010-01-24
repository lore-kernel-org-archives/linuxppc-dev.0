Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3370B7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Jan 2010 14:03:01 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc: implement arch_scale_smt_power for Power7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <4B577F1A.9060907@austin.ibm.com>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<26556.1264021443@neuling.org> <4B577F1A.9060907@austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jan 2010 14:00:28 +1100
Message-ID: <1264302028.3601.36.camel@pasglop>
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

On Wed, 2010-01-20 at 16:09 -0600, Joel Schopp wrote:
> I can turn that into a conditional branch (case statement) with a shift 
> for the common 1,2,4 cases which should cover all procs available today 
> falling back to a divide for any theoretical future processors that do 
> other numbers of threads. 

Look at the cputhreads.h implementation ... Today we only support
power-of-two numbers of threads.

Cheers,
Ben.
