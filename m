Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id BDD8C68593
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 06:47:03 +1000 (EST)
Date: Thu, 27 Oct 2005 13:47:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Sven Luther <sven.luther@wanadoo.fr>
Message-ID: <20051027204708.GE13847@mag.az.mvista.com>
References: <ec55b17e0510270617k368b4555gf3f37e07cee3b4e6@mail.gmail.com>
	<20051027181751.GD9628@mag.az.mvista.com>
	<20051027184921.GA11742@localhost.localdomain>
	<20051027200447.GC13847@mag.az.mvista.com>
	<20051027203017.GA13787@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051027203017.GA13787@localhost.localdomain>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Board based on MPC7447 and MV64462
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

For the record, Sven, Matt Porter, and I talked about this some more on
IRC.  I think we agreed that the best solution would be to register a
pci quirk for the bad regs and no longer hide the bridge.

Anyone think that's a bad idea?

Mark
