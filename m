Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4317CDE006
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 15:08:24 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
	<F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Fri, 1 Jun 2007 00:08:12 -0500
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 31, 2007, at 9:01 PM, Zhang Wei-r63237 wrote:

> Hi, Kumar,
>
>>
>> Can this be fixed by just setting hose->bus_offset in add_bridge?
>>
>> Doing this in exclude is very bad.
>
> That's my original doing. If there a PCI bridge card be pluged into  
> PCI
> slot of hose0, I can not ensue the bus_offset number of hose1.

Ok, but can't we use hose0's last_busno and use that set hose1- 
 >first_busno & hose1->bus_offset?

- k
