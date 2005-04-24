Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D18D67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 10:00:52 +1000 (EST)
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHKEILCLAA.Joakim.Tjernlund@lumentis.se>
References: <BCEFJBPJCGFCNMMMIDBHKEILCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <72ea00c21943f86d32f1a46a62ebc367@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 23 Apr 2005 20:00:39 -0400
To: <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
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


On Apr 23, 2005, at 7:51 PM, Joakim Tjernlund wrote:

> hmm, I have more than 24MB of memory and I can run CONFIG_PIN_TLB just
> fine with modules off in kernel 2.4. Havn't tried 2.6 yet.

Doh.  Oh, I see.  We only do the optimization for the instruction 
misses.
I'll have to take a closer look at Marcelo's 2.6 tests.


	-- Dan
