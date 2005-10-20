Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp11.wanadoo.fr (smtp11.wanadoo.fr [193.252.22.31])
	by ozlabs.org (Postfix) with ESMTP id DF6D068624
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 01:40:06 +1000 (EST)
Received: from smtp11.wanadoo.fr (mwinf1104 [172.22.142.26])
	by mwinf1110.wanadoo.fr (SMTP Server) with ESMTP id B8A5B1C02B46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 17:17:35 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1104.wanadoo.fr (SMTP Server) with ESMTP id 87CB21C001C0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 17:17:32 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-59-200.w82-126.abo.wanadoo.fr
	[82.126.135.200])
	by mwinf1104.wanadoo.fr (SMTP Server) with ESMTP id E95811C00214
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 17:17:31 +0200 (CEST)
Date: Thu, 20 Oct 2005 17:04:50 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20051020150450.GA27704@localhost.localdomain>
References: <ec55b17e0510130042m6c6c0c43ndf09f40a03f9cf97@mail.gmail.com>
	<20051013182654.GA18497@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051013182654.GA18497@mag.az.mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC7447A based board with MV64462 Marvell Discovery III
	controller
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 13, 2005 at 11:26:54AM -0700, Mark A. Greer wrote:
> On Thu, Oct 13, 2005 at 01:12:19PM +0530, Ashish Bijlani wrote:
> > Hi,
> > 
> > I'm trying to bring MPC7447A based board with MV64462 Marvell Discovery III
> > controller up. Can you guide me to Linux-2.6 sources with support for
> > MV64462 Marvell Discovery III controller and MPC7447A PowerPC processor.
> > Support for I2c, dual 10/100/1000 ethernet ports, and relevant platform
> > should be there. I cannot access the bit keeper repositories so please guide
> > me to the linux-2.6 kernel source tree if you can.
> 
> Ashish,
> 
> Support for both the 7447A and mv64x6x is in the latest 2.6 mainline
> kernel source at kernel.org.
> 
> If your board is a chrp/openfirmware board, then you probably want to use
> the Pegasos code as an example.  If your board has U-boot or some other

Hey, we have code to boot the Freeserv with chrp/Of, need to clean it up and
merge it though. Would this be a good thing to submit for mainline inclusion,
it is a couple of lines at most, altough there is some reuse of the interrupt
controller code i think, which needs some cleanup.

Friendly,

Sven Luther
