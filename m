Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9961DE0AE
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 04:31:17 +1000 (EST)
Subject: Re: [PATCH v5 1/4] powerpc: Introduce local (non-broadcast) forms
	of tlb invalidates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1221578145-29102-1-git-send-email-galak@kernel.crashing.org>
References: <1221578145-29102-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 16 Sep 2008 11:31:09 -0700
Message-Id: <1221589869.12463.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  static inline void flush_tlb_kernel_range(unsigned long start,
>  					  unsigned long end)
>  {
> -	_tlbia();
> +	_tlbil_all();
>  }

I love making you respin your patches so what about the one above
becomes tlbil_pid(0) ? :-)

Cheers,
Ben.
