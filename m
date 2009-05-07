Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92569DDDB2
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 01:21:29 +1000 (EST)
Message-Id: <AF270294-0B90-4935-9D4A-F17EB7811CE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jan Neskudla <jan.neskudla.ext@nsn.com>
In-Reply-To: <1241705447.19689.114.camel@demuxf9c>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 0/5] rapidio: adding memory mapping IO support and misc
	fixes
Date: Thu, 7 May 2009 10:21:20 -0500
References: <1241705447.19689.114.camel@demuxf9c>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2009, at 9:10 AM, Jan Neskudla wrote:

> And one more think, when I enabled usage of DMA, rionet does not  
> compile too,
> but in this case I do not have a fix. I tested this on kernel  
> 2.6.29.1 and
> EP8548 as target board.

What exactly do you mean by that?  What CONFIG options cause compile  
failure?  Can you post the compiler error.

- k
