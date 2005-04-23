Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D04467B15
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 07:32:41 +1000 (EST)
In-Reply-To: <20050423124245.GJ12703@logos.cnet>
References: <BCEFJBPJCGFCNMMMIDBHMEIHCLAA.Joakim.Tjernlund@lumentis.se>
	<20050423124245.GJ12703@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <31d4fa0af2a0d11f029d675ae5bd331c@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 23 Apr 2005 17:32:27 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 23, 2005, at 8:42 AM, Marcelo Tosatti wrote:

>> Does CONFIG_PIN_TLB make a difference?
>
> No it does not.

For some reason this option and code didn't make it from
2.4 to 2.6.  It should have some effect on small memory (16Mbyte)
systems with processor that have more than 16 TLB entries.


	-- Dan
