Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 980AADDEBD
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 01:32:31 +1000 (EST)
In-Reply-To: <20070621141519.GQ5417@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: network load 8245 vs. 8347E
Date: Thu, 21 Jun 2007 10:33:21 -0500
To: Marc Leeman <marc.leeman@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 21, 2007, at 9:15 AM, Marc Leeman wrote:

> Ok, I guess it's comparing apples to lemons here, but I'll have a  
> go at
> it anyway.
>
> I'm trying to figure out why partial network decoding on an 8347E is
> disappointingly slow wrt an older 8245 processor.
>
> When simply receiving (cf. att) a multicast stream of 12 Mbps, an
> 8245/uclibc 0.9.28 @350 MHz, ppc arch , the system runs smoothly at a
> load of around 4% on a e100 based MAC (pci:  8086:1209 ).
>
> When doing the same thing on 8347e/0.9.28 @400 Mhz, powerpc arch, the
> system is loaded at around 34%.
>
> any clues?

How are you measuring load?  I'm assuming the 8245 and 8347 are using  
the same kernel.

- k
