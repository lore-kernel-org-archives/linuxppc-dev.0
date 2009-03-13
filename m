Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4432DDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 08:26:52 +1100 (EST)
Subject: Re: [RFC][PATCH v3] powerpc: e300c2/c3/c4 TLB errata workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1236957383-20240-1-git-send-email-galak@kernel.crashing.org>
References: <1236957383-20240-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 08:26:42 +1100
Message-Id: <1236979602.25062.55.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david.jander@protonic.nl, wd@denx.de,
	gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +BEGIN_FTR_SECTION
> +	b      TlbWo    /* Code for TLB-errata workaround doesn't fit here */
> +END_FTR_SECTION_IFSET(CPU_FTR_NEED_DTLB_SW_LRU)
> +RFTlbWo:

Can you use nicer label names ? :-)

Also, that's a lot of code for such a hot path...

Cheers,
Ben.
