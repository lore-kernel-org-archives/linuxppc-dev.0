Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA82667A5C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 00:33:01 +1000 (EST)
Date: Thu, 30 Jun 2005 15:32:33 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "Mark Chambers" <markc@mail.com>
Message-Id: <20050630153233.42a63bda.ajz@cambridgebroadband.com>
In-Reply-To: <006201c57d7c$b36bcb90$0301a8c0@chuck2>
References: <s2c4153f.011@scms1.sc.signaal.nl>
	<006201c57d7c$b36bcb90$0301a8c0@chuck2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: eth0 autonegotation 8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> >We are using a 8260 processor with ELDK 3.1.1,  kernel 2.4.25 patched with
> >lck1. We have configured the kernel with USE_MDIO 
> >and LXT971.
> >The problem we face is that the boot process stops after displaying the
> >configuration of the card:
> >eth0: config: autonegotiation on, 100FDX,...
> >and after the board seems to freeze.
> >
> >Can anybody provide some feedback on how to check what can be misconfigured
> >or where to look for the error???
> 
> Check that the interrupt from the LXT971 is configured correctly.
> The code is probably waiting for this interrupt to tell it that negotiation
> is complete
> 

On a similar note... I've noticed that the fcc_enet driver does not appear to
detect when the link goes down, or re-autonegotiate when it comes back up.  I
wonder if anybody has a fix for this?

PS I too am using the ELDK 3.1.1 linux-2.4.25 kernel, but with a PM828 devel
board.
