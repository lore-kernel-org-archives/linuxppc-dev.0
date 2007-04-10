Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3924DDDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 05:05:13 +1000 (EST)
In-Reply-To: <461BDB69.4050405@freescale.com>
References: <11757244213581-git-send-email-timur@freescale.com>	<461AAF2F.2020608@freescale.com>
	<DEB47A44-7FBF-40AD-B409-12A9BFA35976@kernel.crashing.org>
	<461BDB69.4050405@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EB6E9F47-C92F-48E0-BC98-13AA3B9C0027@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: change rheap functions to use ulongs instead
	of pointers
Date: Tue, 10 Apr 2007 14:04:44 -0500
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


On Apr 10, 2007, at 1:46 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> If we are "cleaning up" rheap I would suggest we think about  
>> moving  it to the generic lib directory and have it available for  
>> wider use  beyond powerpc.
>
> I'm not saying that's a bad idea, but that really is outside the  
> scope of my intentions. I'm not really cleaning up rheap as I am  
> fixing one specific problem.

What's the specific problem you are fixing?  Its not obvious that  
this patch is addressing a bug.

> I don't think there's any disagreement here that an integer type  
> (in this case, unsigned long) is better than a void * for storing a  
> generic value.  I was really hoping I could get a consensus on  
> whether or not *this* patch is good for *our* rheap implementation.

- k
