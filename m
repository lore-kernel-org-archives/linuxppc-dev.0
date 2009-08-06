Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep32-int.chello.at (viefep32-int.chello.at [62.179.121.50])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A51E5B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 01:14:47 +1000 (EST)
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: svaidy@linux.vnet.ibm.com
In-Reply-To: <20090806043351.GC14333@dirshya.in.ibm.com>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090806043351.GC14333@dirshya.in.ibm.com>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 17:03:18 +0200
Message-Id: <1249570998.32113.499.camel@twins>
Mime-Version: 1.0
Cc: "Brown, Len" <len.brown@intel.com>, Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Shaohua Li <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-06 at 10:03 +0530, Vaidyanathan Srinivasan wrote:
> This was the
> main objection to Venki's deepest sleep state for offline cpus patch.

Well, my main objection was that is was a single raw function pointer
without any management layer around it.

We have the exact same mess with the idle routine - and that has bitten
us in the past.
