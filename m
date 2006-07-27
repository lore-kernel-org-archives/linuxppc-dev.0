Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4BE4C67B57
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 04:51:07 +1000 (EST)
In-Reply-To: <67FD272C-C378-4549-8B35-70912AFAB7EF@kernel.crashing.org>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<67FD272C-C378-4549-8B35-70912AFAB7EF@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5B4D8BA2-0991-42D6-8876-6DFE0A85F4E6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][2/2] RTAS MSI
Date: Thu, 27 Jul 2006 20:50:59 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +msiobj-$(CONFIG_IA64_GENERIC) += msi.o msi-apic.o msi-altix.o
>> +msiobj-$(CONFIG_IA64_SGI_SN2) += msi.o msi-apic.o msi-altix.o
>
> These two lines don't need the msi.o and msi-altix.o AFAICS.

s/altix/apic/.  Duh.


Segher
