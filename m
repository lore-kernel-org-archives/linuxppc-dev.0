Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E825767A04
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Mar 2006 09:28:06 +1100 (EST)
In-Reply-To: <dvsds7$ta0$1@sea.gmane.org>
References: <dvsds7$ta0$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E895715F-A853-4A27-8076-90A1973273E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: swizzling pci irqs
Date: Wed, 22 Mar 2006 16:28:52 -0600
To: David Updegraff <dave@cray.com>
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


On Mar 22, 2006, at 2:59 PM, David Updegraff wrote:

> Hi.
>
> If there were a noswizzle option to the kernel command line that
> resulted in pci scan simply trusting that the bootrom/u-boot had  
> already
> correctly assigned the PCI irqs....  every tom,dick,harry, and
> yours-truly wouldn't have to make a new platform to define the
> swizzle-o-the-day.  Or have I already missed this argument?

Sure, I do this now.  Just don't build pci_auto into your pci support  
and don't explicitly rescan in your pci setup.  The 83xx pci code  
under arch/powerpc should effective do this.

- kumar
