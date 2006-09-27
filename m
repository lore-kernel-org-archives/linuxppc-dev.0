Return-Path: <moilanen@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3511679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 05:46:56 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8RJkr0c008193
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 15:46:53 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8RJkike524248
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 13:46:45 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8RJkisx002512
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 13:46:44 -0600
Subject: Re: [RFC/PATCH 4/4] Enable MSI on Powerpc
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20060818081331.E6F7267B5D@ozlabs.org>
References: <20060818081331.E6F7267B5D@ozlabs.org>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 14:46:05 -0500
Message-Id: <1159386365.5542.115.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-18 at 18:13 +1000, Michael Ellerman wrote:
> Allow PCI_MSI to build on POWERPC.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  drivers/pci/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: git/drivers/pci/Kconfig
> ===================================================================
> --- git.orig/drivers/pci/Kconfig
> +++ git/drivers/pci/Kconfig
> @@ -4,7 +4,7 @@
>  config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
>  	depends on PCI
> -	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
> +	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64 || POWERPC

Shouldn't this be PPC?

>  	help
>  	   This allows device drivers to enable MSI (Message Signaled
>  	   Interrupts).  Message Signaled Interrupts enable a device to
