Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43701DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 09:18:43 +1100 (EST)
Message-Id: <E0243CA4-29EA-4148-936C-817CDC12F5D1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071204220432.GA2521@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [FDT][PATCH] Fix padding options
Date: Tue, 4 Dec 2007 16:18:31 -0600
References: <Pine.LNX.4.64.0712041027330.29174@blarg.am.freescale.net>
	<20071204220432.GA2521@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I guess it was really git commit  
2b7dc8dce549ad72ad437b254bf756d7ba4c2a5a

Add an option to pad the blob that is generated

- k

On Dec 4, 2007, at 4:04 PM, David Gibson wrote:

> On Tue, Dec 04, 2007 at 10:27:52AM -0600, Kumar Gala wrote:
>> commit 22e787ca2b1e49a9a0f3c43262564ab1038c5c3c broke the padding
>> support.  We were updating the fdt header after writing it.
>
> Uh.. I can't find a commit with that SHA1.  Which one are you
> referring to?
>
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_  
> _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
