Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id EE0FF67A63
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 01:58:50 +1100 (EST)
In-Reply-To: <1105956993.26551.327.camel@hades.cambridge.redhat.com>
References: <1105956993.26551.327.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38A2A735-6898-11D9-AF22-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 17 Jan 2005 08:58:17 -0600
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	hpa@zytor.com
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]

> This makes it compile on PPC, but highlights the difference between
>  'cur_cpu_spec' on ppc32 and ppc64. Why is 'cur_cpu_spec' an array on
>  ppc32? Isn't 'cur' supposed to imply 'current'?

I can only guess to handle an SMP case with two different revs of the 
same processor that might have slightly different errata.

- kumar
