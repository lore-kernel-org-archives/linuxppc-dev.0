Return-Path: <ALEBAS@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 08F8267B83
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 18:05:54 +1000 (EST)
Message-ID: <1144835330.443ccd021b40a@webmail.televes.com:443>
Date: Wed, 12 Apr 2006 11:48:50 +0200
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Watchdog on MPC82xx
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi list,

I am trying to use the on-chip watchdog timer in the MPC8248 to
recover from system hangs.

I have been following the guidelines from the changes I have found
from Compulab.

In u-boot, the watchdog is activated and works fine. The changes in
the kernel are, basically, assigning the ppd_md.heartbeat to a function
which resets the watchdog. This is supposed to start reseting the wdt
after ppc_md.setup_arch is invoked, but this is not working, and the
kernel keeps rebooting during startup.

I have tried to catch the point when this happens to force a WD service
sequence before that, but I had no success.

So, can anyone give me some guidelines for this job? I have seen from
freescale docs that MPC83xx watchdog may be the same than MPC82xx one.
So, could I use the same approach than used on MPC83xx boards?

http://patchwork.ozlabs.org/linuxppc//patch?id=4118


Thanks in advance

Alex
