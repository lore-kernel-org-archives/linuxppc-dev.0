Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 73158DDEF9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Aug 2007 02:20:28 +1000 (EST)
Date: 24 Aug 2007 09:13:05 -0700
Message-ID: <20070824161305.27479.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: joachim.bader@diehl-aerospace.de, linuxppc-embedded@ozlabs.org
Subject: Re: [linux kernel 2.6.19] ethernet driver for Marvell bridge GT-64260
In-Reply-To: <OF2C2E8C6F.3860730F-ONC1257341.004B3D4B-C1257341.004C2882@diehl-gruppe.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I continue the work of ThomasB to get a linux kernel 2.6.19 up and running
> on a PPC750FX based platform using a GT-64260.
> From Thomas I got a patched mv643xx_eth driver which is ported to support
> the 64260, too.
> Now the driver is integrated and runs complete through initialisation
> bringing up an eth0 device.
> The initialisation seams to be ok (no error messages), the device is up
> and routing information is setup.
> Now I try to ping a remote station but I receive nothing and I get no
> feedback from the remote compter.
> As soon as I turn of the net interface (ifconfig eth0 down) I get the
> message "Tx time out or no link?)
> Is there anything else I can check? Any idea what may cause this problem?

Steven Hill posted his patch series merging gt64260 ethernet support to
the netdev mailing list last month.  You might look at:

	http://lists.openwall.net/netdev/2007/07/19/22

and related patches.

The differences between 64260 and 64360 are so large that they are
unlikely to be merged into a single driver, but a separate driver
is a possibility if someone steps up to do the work.

-Dale
