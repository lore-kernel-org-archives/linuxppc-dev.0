Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 5DAFA67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 02:42:51 +1100 (EST)
Date: Fri, 4 Mar 2005 08:42:30 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Matthias Babylon <m.babylon@hima.com>
Message-ID: <20050304084230.B2508@cox.net>
References: <20050303225032.85E4967A82@ozlabs.org>
	<000401c5208c$69076610$f101a8c0@SN7605>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000401c5208c$69076610$f101a8c0@SN7605>;
	from m.babylon@hima.com on Fri, Mar 04, 2005 at 08:33:06AM +0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet & PCI Driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2005 at 08:33:06AM +0100, Matthias Babylon wrote:
> Hi,
> 
> we decided to port a 2.6.Kernel from scratch to PPC440GX based board. now
> i'm on search for an ethernet & pci driver for the 440GX. some time ago i've
> found some drivers, but i forgot the links....can somebody help me??

What do you mean "an ethernet & pci driver"?  Are you looking for an
EMAC driver? Do you mean support for the PCI host bridge? It's all in
the mainline kernel. Just use the ocotea port as a starting point and
things should go quickly.

-Matt
