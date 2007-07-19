Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 152B2DDF7D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 07:19:18 +1000 (EST)
In-Reply-To: <20070719161013.9f982d8f.kim.phillips@freescale.com>
References: <20070713184452.466490031@arndb.de>
	<20070713184824.312271421@arndb.de>
	<20070719161013.9f982d8f.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <98677159-8FF2-4D6F-802D-2A82C1F33D70@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/5] move 83xx into multiplatform
Date: Thu, 19 Jul 2007 16:19:34 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 19, 2007, at 4:10 PM, Kim Phillips wrote:

> On Fri, 13 Jul 2007 20:44:57 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> MPC83xx based machines don't need their own kernel,
>> but can run one that is shared with the other 6xx
>> compatible machines, so we should allow that
>> in Kconfig.
>>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> tested, works.  Kumar, can we get this in?

Maybe, I need to get at least on PCI patch to makes PCI indirect ops  
runtime select big/little endian.

- k
