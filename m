Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9BBE67B59
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Jun 2005 00:03:06 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DnGYH-0003iy-2b
	for linuxppc-embedded@ozlabs.org; Tue, 28 Jun 2005 15:55:01 +0200
Received: from s0106000024c002e0.ss.shawcable.net ([70.64.46.12])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 28 Jun 2005 15:55:01 +0200
Received: from jbi130 by s0106000024c002e0.ss.shawcable.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 28 Jun 2005 15:55:01 +0200
To: linuxppc-embedded@ozlabs.org
From: jbi130@yahoo.com
Date: 28 Jun 2005 08:03:08 -0600
Message-ID: <87zmtavasj.fsf@nimrod.unx.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: 2.6 support for MPC8541(e)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've recently received a GDA PCI-G8400 evaluation board with an
MPC8541E.  It came with u-boot 1.1.2 and a 2.4.27 kernel.

Our hopes are to get a 2.6 kernel running on this device so it is in
sync with out MPC8248 based boards.

What is the status of the support for these chips?  When I enable
CONFIG_SERIAL_TEXT_DEBUG I'm able to get some output, it seems to die
when initializing openpic.  There also appears to be issues with the
serial console as I'm not getting printk output at all, and I think I
should be by the time start_kernel is entered.

My current 2.6.12 builds use the MPC8540_ADS configs as a base.  The
2.4 that was received with the board does as well.

For now I'm not concerned with the 'E' part.  My main job is to
actually add support for the security engine, but I'd like to get 2.6
up and running first.  Yes, this is my first jump into machine
specific code..

Thanks.
