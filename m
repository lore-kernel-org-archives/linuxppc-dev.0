Date: Thu, 12 Oct 2000 17:53:22 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: pmac_power_off is gone in 2.2.17
Message-ID: <20001012175322.A5273@suse.de>
Reply-To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

the pmac_power_off() call in pmac_halt() disappeared in 2.2.17.
Is there any special reason for that? I affects proably only B&W
machines, /sbin/halt doesnt work anymore.


Can we have it back?


diff -urN linux-2.2.17/arch/ppc/kernel/pmac_setup.c linux-2.2.17.poweroff/arch/ppc/kernel/pmac_setup.c
--- linux-2.2.17/arch/ppc/kernel/pmac_setup.c   Mon Sep  4 19:39:16 2000
+++ linux-2.2.17.poweroff/arch/ppc/kernel/pmac_setup.c  Thu Oct 12 17:49:03 2000
@@ -551,6 +551,7 @@
 void
 pmac_halt(void)
 {
+pmac_power_off();
 }




Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
