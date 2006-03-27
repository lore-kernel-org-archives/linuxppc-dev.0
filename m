Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C963E67A5C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 00:55:04 +1100 (EST)
Received: from vitb.ru.mvista.com ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k2RDt2s08498
	for <linuxppc-embedded@ozlabs.org>; Mon, 27 Mar 2006 18:55:02 +0500
Date: Mon, 27 Mar 2006 17:55:04 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: freescale 8xx: which architecture to use ? ppc - powerpc ?
Message-ID: <20060327175504.40536812@vitb.ru.mvista.com>
In-Reply-To: <4427E693.6060601@cs.fau.de>
References: <4427E693.6060601@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 27 Mar 2006 15:20:19 +0200
Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de> wrote:

> 
> Hello,
> 
> i want to run linux (2.6.15) on my MPC875 board. I wonder which 
> architecture to choose:  "powerpc" or "ppc" ? - menuconfig shows a 
> "freescale 8xx" option when used with "powerpc", and a "8xx" option when 
> used with ARCH=ppc. Because i use a embedded freescale 8xx i wanted to 
> use the "powerpc" architecture. BUT: i seems to be unstable, i got some 
> undefined referencies. Or am i wrong ?
You should use ppc for now. Work to move the 8xx stuff to the powerpc is ongoing, but quite far from complete state as you see...

> 
> thanks
> Josef
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
