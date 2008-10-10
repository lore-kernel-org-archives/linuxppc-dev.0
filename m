Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D77BDDF9E
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:34 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:14 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-0@bga.com>
Subject: [PATCH 00/16] xics and ipi cleanups for 2.6.28
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The first two patches in this series implememnt a couple of bug
fixes for the xics interrupt controller accessed as found in pseries
hardware.  The next several patches implement some code orginization
and cleanups, followed by some changes to reduce code or flag the
behavior to generic code.

The last 5 patces are independent of the xics changes, although the
first one affects xics.  They are designed to reduce interrupt
overhead for interprocessor interupts.  

While I would have liked to do more testing where I have access to
the hardware (which is only xics), I am sending them out now for
review and consdieration for the merge window.  All have been compile
tested, and I feel they are split into reviewable pieces.

milton
