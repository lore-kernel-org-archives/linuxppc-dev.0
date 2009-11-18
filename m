Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6A021007D3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 17:06:07 +1100 (EST)
Subject: Re: [PATCH 0/4] powerpc: Fix minor build issues on 2.6.32-rc7
	without CONFIG_XICS set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
References: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Nov 2009 17:05:32 +1100
Message-ID: <1258524332.2140.663.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-17 at 12:07 +0000, Mel Gorman wrote:
> KConfig doesn't require CONFIG_XICS to be set with CONFIG_PSERIES but if
> it's not set, there are numerous small build errors. This is a small series
> of patches to allow CONFIG_XICS to be unset in the config.
> 
> XICS appears to be some sort of interrupt controller but I'm not sure how
> common it is on systems that require CONFIG_PSERIES. If CONFIG_PSERIES
> universally requires CONFIG_XICS, the better path might be to force it to
> be set.
> 
> Testing was building with make oldconfig a configuration from 2.6.31 on
> a PPC970.

CONFIG_XICS should be made invisible and selected by PSERIES.

Cheers,
Ben.
