Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 4E1E2DDFFF
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:18:01 +1100 (EST)
Date: Wed, 10 Dec 2008 16:17:58 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Ayman El-Khashab <AymanE@tanisys.com>
Subject: Re: Help enabling PCI endpoint on 460EX, host sees disabled
Message-ID: <20081211001758.GA29190@ovro.caltech.edu>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F8AD@tanisys-ex2.Tanisys.Local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F8AD@tanisys-ex2.Tanisys.Local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 10, 2008 at 05:29:53PM -0600, Ayman El-Khashab wrote:
> My system consists of a pair of 460EXs attached by way of both PCI-E and
> PCI.  Ultimately my goal is to communicate between them via pci-e (is
> there anything out there that does this already?).

I can't help you with that exact board, but I've written an "ethernet
over PCI" driver for Linux and U-Boot. The Linux driver has been posted
here on linuxppc-dev and on the lkml. Search for "net: add PCINet
driver" and you'll find it.

It won't work on your board, but it should serve as a good example about
how to communicate over PCI.

You are the third user asking for something like this recently. :) Too
bad the mainline kernel developers seem to be mostly ignoring the
driver I wrote.

Definitely get PCI/PCI-E working and stable before you try to start
communicating between the devices, though.

Ira
