Return-Path: <SSparks@aclaratech.com>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 5922DDE31E
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:00:31 +1000 (EST)
Received: from mail166-sin (localhost.localdomain [127.0.0.1])	by
	mail166-sin-R.bigfish.com (Postfix) with ESMTP id 92CCC16F8278	for
	<linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 16:00:27 +0000 (UTC)
Received: from acl-exch.aclaratech.com (unknown [68.89.149.23])	by
	mail166-sin.bigfish.com (Postfix) with ESMTP id 5AF1684005C	for
	<linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 16:00:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Compact flash on mpc8349eITX
Date: Fri, 1 Aug 2008 10:58:58 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A835560863421AB@mail.twacs.com>
From: "Sparks, Sam" <SSparks@aclaratech.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to get the compact flash up and running on an mpc8349eITX,
and am continually running into issues where the IRQ is not processed,
and the mmio commands are not getting response. At this point, I am
starting to suspect a HW issue, but I was hoping to verify that I am
using a known good kernel configuration.

Has anyone successfully communicated with a compact flash device in true
IDE mode on the MPC8349eITX? If so, do you happen to know the kernel
configuration and/or revision?

I appreciate any help, as I am really getting stuck here.
Regards,
Sam
