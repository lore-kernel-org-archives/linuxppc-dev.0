Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21830474C1
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 22:04:38 +1100 (EST)
Subject: Re: Help enabling PCI endpoint on 460EX, host sees disabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Snyder <iws@ovro.caltech.edu>
In-Reply-To: <20081211001758.GA29190@ovro.caltech.edu>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F8AD@tanisys-ex2.Tanisys.Local>
	<20081211001758.GA29190@ovro.caltech.edu>
Content-Type: text/plain
Date: Thu, 11 Dec 2008 22:04:28 +1100
Message-Id: <1228993468.22413.165.camel@pasglop>
Mime-Version: 1.0
Cc: Ayman El-Khashab <AymanE@tanisys.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-10 at 16:17 -0800, Ira Snyder wrote:
> On Wed, Dec 10, 2008 at 05:29:53PM -0600, Ayman El-Khashab wrote:
> > My system consists of a pair of 460EXs attached by way of both PCI-E and
> > PCI.  Ultimately my goal is to communicate between them via pci-e (is
> > there anything out there that does this already?).
> 
> I can't help you with that exact board, but I've written an "ethernet
> over PCI" driver for Linux and U-Boot. The Linux driver has been posted
> here on linuxppc-dev and on the lkml. Search for "net: add PCINet
> driver" and you'll find it.
> 
> It won't work on your board, but it should serve as a good example about
> how to communicate over PCI.
> 
> You are the third user asking for something like this recently. :) Too
> bad the mainline kernel developers seem to be mostly ignoring the
> driver I wrote.

Don't get too disappointed... a lot of us are busy and things fall
through the cracks.. it may just be that we had nothing bad to say about
it :-)

Seriously, if you feel you didn't get useful reviews or that nothing is
picking it up, just holler, and nag us. We all have pretty full plates
and things do slip or just forgotten :-)

Cheers,
Ben.
