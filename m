Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 5C3E5DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 09:26:47 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/6] Cleanups to c67x00 USB host controller driver
Date: Tue, 12 Jun 2007 17:02:15 -0600
Message-Id: <11816893411272-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter,

Here's the series of changes that I've made to the c67x00 driver.  Most of
them are pretty straight forward.  Most invasive is the rename of
'struct c67x00_drv' to 'struct c67x00_device' which is big and scary, but
doesn't really do much.

One thing that I haven't tackled is the layout of the lowlevel drivers.
I think it should be reworked to add a generic ops structure which each
low level driver can populate with the correct ops functions.  It should
simplify the code from the hard coded approach currently used.

I'll probably have more comments/fixes later as I work with it, but this
series is what I have now.  Please add me to the CC list when you repost
an updated driver to the list.  I'm not subscribed to linux-usb-devel.

Cheers,
g.
