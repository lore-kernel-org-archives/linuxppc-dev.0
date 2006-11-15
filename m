Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7788E67C6E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 11:54:48 +1100 (EST)
In-Reply-To: <BAY102-F1446B29A3C6918114ADE69A9EA0@phx.gbl>
References: <BAY102-F1446B29A3C6918114ADE69A9EA0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3679DAB4-C7A5-4A47-9648-2CC0F87F76F7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Low memory not pageable on Freescale BookE
Date: Tue, 14 Nov 2006 18:55:02 -0600
To: "M Ptich" <ptich@hotmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 14, 2006, at 6:38 PM, M Ptich wrote:

>> Why do you need low kernel memory to be pageable?
>
> Mainly for debugging purposes - this way we can have guardbands for  
> our application stacks, and also for proprietary software that  
> tracks memory accesses (for corruption detection).

If you are doing at the application level then its already paged.   
The TLB1 stuff is just for kernel memory.

- k
