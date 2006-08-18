Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EBD6267B8C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 23:04:02 +1000 (EST)
In-Reply-To: <20060818081330.9ADC867B55@ozlabs.org>
References: <20060818081330.9ADC867B55@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BCF9126B-1B01-435C-94C6-E2DABF07B23D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/4] Allow for non-Intel MSI implementations
Date: Fri, 18 Aug 2006 15:03:36 +0200
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -msiobj-y := msi.o msi-apic.o
> -msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
> -msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
> +msiobj-$(CONFIG_X86) := msi.o msi-apic.o
> +msiobj-$(CONFIG_IA64) := msi.o msi-apic.o
> +msiobj-$(CONFIG_IA64_GENERIC) := msi-altix.o
> +msiobj-$(CONFIG_IA64_SGI_SN2) := msi-altix.o

The msi-altix changes are wrong, /me thinks.


Segher
