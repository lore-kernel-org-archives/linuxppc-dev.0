Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 922BBDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 02:11:07 +1000 (EST)
In-Reply-To: <20070802152846.GA4468@ld0162-tx32.am.freescale.net>
References: <20070801192009.656fc2e0.kim.phillips@freescale.com>
	<995B09A8299C2C44B59866F6391D2635AAD0C5@zch01exm21.fsl.freescale.net>
	<20070802152846.GA4468@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FEFE1734-0728-4C9E-90D4-7CA428AB41C3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [U-Boot-Users] MPC83xx - previous patch to set MBAR
Date: Thu, 2 Aug 2007 11:12:03 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Liu Dave-r63238 <DaveLiu@freescale.com>, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 2, 2007, at 10:28 AM, Scott Wood wrote:

> On Thu, Aug 02, 2007 at 10:14:31AM +0800, Liu Dave-r63238 wrote:
>>> MBAR doesn't live up to its name.  It's a general-purpose scratch
>>> register - the hardware doesn't do anything with it.  So, wrt
>
> That doesn't mean there isn't value in setting it, so code can easily
> find the IMMR without having to parse the device tree.

It could be, but there isn't really any value in doing this since its  
in the device-tree and we have to find it for 85xx, 86xx, and pretty  
much all our parts.

- k
