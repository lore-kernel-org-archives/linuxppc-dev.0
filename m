Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep20-int.chello.at (viefep20-int.chello.at [62.179.121.40])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8AF37B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 21:33:25 +1000 (EST)
Subject: Re: [v2 PATCH 2/2]: pseries: Implement Pseries Processor Idle idle
	module.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20090826111003.GC29759@linux.vnet.ibm.com>
References: <20090826110721.GA29759@linux.vnet.ibm.com>
	<20090826111003.GC29759@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Aug 2009 13:27:18 +0200
Message-Id: <1251286038.1329.1.camel@twins>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-26 at 16:40 +0530, Arun R Bharadwaj wrote:
> +void (*pm_idle)(void);
> +EXPORT_SYMBOL_GPL(pm_idle);

Seriously.. this caused plenty problems over on x86 and you're doing the
exact same dumb thing?
