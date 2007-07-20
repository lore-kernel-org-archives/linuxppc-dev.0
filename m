Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2681DDDE4
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 07:11:57 +1000 (EST)
In-Reply-To: <46A10578.6030609@mvista.com>
References: <46A10578.6030609@mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF1A9889-840C-4D19-9824-177DFEFE298F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6] 85xxCDS: Misc 8548 PCI Corrections.
Date: Fri, 20 Jul 2007 16:11:55 -0500
To: Randy Vinson <rvinson@mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 20, 2007, at 1:56 PM, Randy Vinson wrote:

>> From cf18185b4e201ff45f2e2a948103dd3dc088c046 Mon Sep 17 00:00:00  
>> 2001
> From: Randy Vinson <rvinson@mvista.com>
> Date: Thu, 19 Jul 2007 10:40:53 -0700
> Subject: [PATCH] 85xxCDS: Misc 8548 PCI Corrections.
>
> Setting the host bridge @8000 as primary and only calling  
> setup_pci_atmu
> for the PCI Express host bridge. Also fixing a bug in setting the USB
> interrupt numbers.

What issue exists with calling setup_pci_atmu on normal PCI?

- k
