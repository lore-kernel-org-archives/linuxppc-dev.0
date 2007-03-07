Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id ACA55DE050
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 08:14:13 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l27LEAWR013297
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 14:14:10 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l27LEApN001454
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 15:14:10 -0600 (CST)
Subject: [RFC 0/3] MPC8544 DS Request for Comments
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173302049.23776.181.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 07 Mar 2007 15:14:09 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

This series of 3 patches form the basis for the
MPC8544 DS port.  These are not a complete port
patch set, as there is still some resolution and
work needed on resolving some PCI and PCI-Express
similarities with 86xx on the event horizon.

In the meantime, I would appreciate any comments
and feedback on the basic port as it stands today.
I have not yet gone over these with a fine-tooth
Anton Blanchard, so there may be some rough spots
in here still. Feel free to nudge me with a Franklin.

Thanks,
jdl
