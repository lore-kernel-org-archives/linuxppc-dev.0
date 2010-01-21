Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B516AB7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 19:31:00 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc: implement arch_scale_smt_power for Power7
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <4B578731.2060709@austin.ibm.com>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<1264020517.4283.1117.camel@laptop> <4B578731.2060709@austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Jan 2010 09:27:39 +0100
Message-ID: <1264062459.4283.1129.camel@laptop>
Mime-Version: 1.0
Cc: ego@in.ibm.com, Andreas Herrmann <andreas.herrmann3@amd.com>,
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

On Wed, 2010-01-20 at 16:44 -0600, Joel Schopp wrote:
> 
> Care to take Gautham's bugfix patch (patch 1/2) now, since it just fixes 
> a bug?  You'll need it if you ever try to make the x86 broken version work.

Sure, I'll take that, thanks!
