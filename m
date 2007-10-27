Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4291DDF15
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 04:57:49 +1100 (EST)
Date: Sat, 27 Oct 2007 19:57:38 +0200 (MEST)
Message-Id: <200710271757.l9RHvcY9021751@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: paulus@samba.org
Subject: 2.6.24-rc1 sysctl table check failed on PowerMac
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Booting 2.6.24-rc1 on my PowerMac the kernel now spits
out a sysctl warning early in the boot sequence:

--- dmesg-2.6.23
+++ dmesg-2.6.24-rc1
...
 IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
 TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
 TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
 TCP: Hash tables configured (established 131072 bind 65536)
 TCP reno registered
+sysctl table check failed: /kernel .1 Writable sysctl directory
 io scheduler noop registered
 io scheduler anticipatory registered (default)
 io scheduler deadline registered
