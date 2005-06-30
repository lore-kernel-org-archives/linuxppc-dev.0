Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C7F667B84
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 01:07:04 +1000 (EST)
Received: from zambia.cambridgebroadband.com (cbluk-gw0.cambridgebroadband.com
	[217.204.121.82])
	by cambridgebroadband.com (8.12.8/8.12.8) with SMTP id j5UF6wG4009340
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Jun 2005 16:06:58 +0100
Date: Thu, 30 Jun 2005 16:06:58 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20050630160658.3ba5a393.ajz@cambridgebroadband.com>
In-Reply-To: <20050630153233.42a63bda.ajz@cambridgebroadband.com>
References: <s2c4153f.011@scms1.sc.signaal.nl>
	<006201c57d7c$b36bcb90$0301a8c0@chuck2>
	<20050630153233.42a63bda.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

> 
> On a similar note... I've noticed that the fcc_enet driver does not appear to
> detect when the link goes down, or re-autonegotiate when it comes back up.  I
> wonder if anybody has a fix for this?
> 
> PS I too am using the ELDK 3.1.1 linux-2.4.25 kernel, but with a PM828 devel
> board.

Sorry all, I think I've spotted the problem now.  From fcc_enet.c:

	/* Some boards don't have the MDIRQ line connected (PM826 is such a board) */

Alex
