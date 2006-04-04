Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53C5667AC5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Apr 2006 14:14:36 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673081427@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673081427@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A8E2BF7-3155-4014-B035-2E677F7ADF2D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: of_platform bus?
Date: Mon, 3 Apr 2006 23:14:55 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 3, 2006, at 10:52 PM, Li Yang-r58472 wrote:

> I noticed that there is a new bus type of_platform_bus added.   
> Current ppc embedded systems are using platform_device, and are  
> changing to use OF flat device tree structure.  Does it mean that  
> current drivers need to be switched from platform_bus to  
> of_platform_bus?

At some point we may look at that.  However, since drivers are shared  
between arch/ppc and arch/powerpc we will continue to use  
platform_device.

- k
