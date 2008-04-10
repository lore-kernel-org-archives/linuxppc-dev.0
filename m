Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BADB4DE1AE
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 07:47:02 +1000 (EST)
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20080410032354.90CB1DDF0F@ozlabs.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
Content-Type: text/plain
Date: Fri, 11 Apr 2008 07:46:18 +1000
Message-Id: <1207863978.6958.15.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +#ifndef thread_info_cache_init
> +#define thread_info_cache_init	do { } while(0)
> +#endif
> +

Blah ! Missing a pair of () here. Ooops. I'll send a fixed patch.

Ben.
