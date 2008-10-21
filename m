Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 506AADDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 09:33:07 +1100 (EST)
Subject: RE: [RFC/PATCH] pci: Workaround invalid P2P bridge bus numbers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F833@tanisys-ex2.Tanisys.Local>
References: <20081020230717.2FD16DDDDB@ozlabs.org>
	<16691A8B34B5D9458EA3A1C37A11555A0137F833@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 09:33:00 +1100
Message-Id: <1224628380.7654.277.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-21 at 09:36 -0500, Ayman El-Khashab wrote:
> > Ayman, can you double check that this variant of the patch still
> > fixes your problem ? Thanks !
> > 
> 
> I've tried it out and it is working correctly with my devices.  The
> subordinate bus numbers on all the ports are correct.

Thanks !

Cheers,
Ben.
