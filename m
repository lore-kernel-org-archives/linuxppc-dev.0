Return-Path: <a.p.zijlstra@chello.nl>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56BCBB7BAB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Oct 2009 05:08:00 +1100 (EST)
Subject: Re: [v7 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
	cpuidle to POWER.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20091006163521.GA10425@linux.vnet.ibm.com>
References: <20091006152421.GA7278@linux.vnet.ibm.com>
	<20091006163521.GA10425@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Tue, 06 Oct 2009 20:04:39 +0200
Message-Id: <1254852279.17055.2.camel@laptop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-06 at 22:05 +0530, Arun R Bharadwaj wrote:

> Also, the per-cpu nature of registration/unregistration of cpuidle
> has been maintained as ACPI needs this.

Right, so can't we ditch that and have acpi default to the lowest common
C-state and warn when various cpus report different C-states?
