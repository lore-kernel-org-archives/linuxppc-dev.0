Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4B99DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 12:48:35 +1100 (EST)
Subject: Re: USB Host controller for MPC8548e board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Kelly <mike@cogcomp.com>
In-Reply-To: <6.2.5.6.2.20070213191530.03e27eb0@cogcomp.com>
References: <6.2.5.6.2.20070213191530.03e27eb0@cogcomp.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 12:48:24 +1100
Message-Id: <1171417704.20192.123.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 19:21 -0500, Michael Kelly wrote:
> Hello all.  We are in the process of designing an MPC8548e board.  We 
> wish to add
> USB host via either the NXP ISP1561 or NEC upd720101.  They are both OHCI and
> EHCI.
> 
> Is there any general advice on one over the other or even if it is 
> realistic to have a USB
> host controller on a big endian processor?

Are they PCI based ? In this case they should pretty much work out of
the box.

Ben.
