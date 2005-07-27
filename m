Return-Path: <hillel.avni@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 9C91D67D87
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 20:36:36 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	j6RAeUZp014645 for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 03:40:30 -0700 (MST)
Received: from zil05exm01.ea.freescale.net (zil05exm01.ea.freescale.net
	[216.3.95.200])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id j6RAgkf5026924
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 05:42:48 -0500 (CDT)
Message-ID: <D39C8B3D64A0D511A61E00D0B7828EEA0C0764FD@zil05exm01.ea.freescale.net>
From: Avni Hillel-R58467 <hillel.avni@freescale.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 27 Jul 2005 13:36:15 +0300
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH][5/5] RapidIO support: net driver over messaging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matt,

Two questions:

A. How can a node (not the host) know who is in the rionet to broadcast to them? 

B. How do you emulate broadcasting to all the mailboxes, in multi mbox systems? Is this done by the node getting the broadcast in MB 0 and forwarding it to the other MBs?

Regards,

Hillel
