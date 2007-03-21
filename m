Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86D2CDDEFC
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 08:46:03 +1100 (EST)
In-Reply-To: <1174508651.10836.4.camel@localhost.localdomain>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
	<11740199152595-git-send-email-wei.zhang@freescale.com>
	<11740199154116-git-send-email-wei.zhang@freescale.com>
	<11740199152381-git-send-email-wei.zhang@freescale.com>
	<1174359820.10827.8.camel@concordia.ozlabs.ibm.com>
	<65a42fd7d277db5f565849a07d8dea90@kernel.crashing.org>
	<1174508651.10836.4.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <016c9b6f097a7688dd80ff73bb68a61b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] Add irq debugfs and virq_mapping for getting the virq
	to irq host's hwirq mapping list.
Date: Wed, 21 Mar 2007 22:45:42 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, r54964@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Or put the whole IRQ tree under sysfs generically...
>
> Except that there is no such thing as an IRQ tree in the generic 
> code...

Darn, I thought the whole cascading thing was done in
generic code now.  Oh well...


Segher
