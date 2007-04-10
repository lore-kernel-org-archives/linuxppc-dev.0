Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A94F0DDF1D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 04:32:24 +1000 (EST)
In-Reply-To: <461AAF2F.2020608@freescale.com>
References: <11757244213581-git-send-email-timur@freescale.com>
	<461AAF2F.2020608@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DEB47A44-7FBF-40AD-B409-12A9BFA35976@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: change rheap functions to use ulongs instead
	of pointers
Date: Tue, 10 Apr 2007 13:31:52 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2007, at 4:25 PM, Timur Tabi wrote:

> Timur Tabi wrote:
>> The rheap allocation functions return a pointer, but the actual  
>> value is based
>> on how the heap was initialized, and so it can be anything, e.g.  
>> an offset
>> into a buffer.  A ulong is a better representation of the value  
>> returned by
>> the allocation functions.
>
> No comments on this patch?  Does this mean that you all think it's  
> okay for 2.6.22?

If we are "cleaning up" rheap I would suggest we think about moving  
it to the generic lib directory and have it available for wider use  
beyond powerpc.

This would also mean getting a wide review by lkml and seeing what  
people think about it returning a ulong vs void *.

- k
