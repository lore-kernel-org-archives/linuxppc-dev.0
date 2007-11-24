Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 550B9DDF3A
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 11:25:36 +1100 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JRZ00L5MIGQ3TE0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 23 Nov 2007 17:24:26 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JRZ0046MIGPZ100@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 23 Nov 2007 17:24:26 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JRZ00I68IGOGV10@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 23 Nov 2007 17:24:25 -0700 (MST)
Date: Fri, 23 Nov 2007 17:24:25 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/5] Review request: Cypress c67x00 OTG controller
To: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org,
	dbrownell@users.sourceforge.net, gregkh@suse.de, linuxppc-dev@ozlabs.org
Message-id: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series is based on the c67x00 work done by Peter Korsgaard and
posted back in April this year.

The Cypress c67x00 is an OTG controller so it can behave as either a host
or gadget controller.  This series implements the HCD behaviour.

The c67x00 is found on a number of the Xilinx MLxxx series of boards.
I've been performing my testing on a board derived from the ML403.

My goal is to get this driver queued up for inclusion in 2.6.25, but I've
been looking at this code for so long that I'm going crosseyed and missing
obvious issues.  Plus, I am by no means a USB expert and I'm not sure that
I'm using the USB HCD API correctly.

So, this email is a request for review.  I've got some time cleared away
to work on this over the next week so I should be able to address comments
quickly with the goal of getting it picked up for the next merge window.

Thanks,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
