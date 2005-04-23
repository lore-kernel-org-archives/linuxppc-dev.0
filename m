Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7768D67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 09:51:45 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Date: Sun, 24 Apr 2005 01:51:34 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHKEILCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4f898cca602f86b36579fd02046c1aac@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> On Apr 23, 2005, at 1:23 PM, Joakim Tjernlund wrote:
> 
> > Does CONFIG_PIN_TLB make a difference?
> 
> While looking at the code, I noticed this will only work
> if you can map all of the memory with wired TLB entries.
> If you have more than 24M of memory, make sure you
> enable CONFIG_MODULES to eliminate the TLB miss
> optimization that will certainly crash a system by failing
> to look up kernel PTEs correctly.

hmm, I have more than 24MB of memory and I can run CONFIG_PIN_TLB just
fine with modules off in kernel 2.4. Havn't tried 2.6 yet.

 Jocke
