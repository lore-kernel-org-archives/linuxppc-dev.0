Return-Path: <a.korud@vector.com.pl>
Received: from mail-ex.vector.com.pl (mail-ex.vector.com.pl [81.210.9.37])
	by ozlabs.org (Postfix) with ESMTP id 6A7A9DDE31
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 02:39:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: 440ep/ge EMAC problems whith simultanious trafic on both Ethernet
	ports
Date: Tue, 6 Feb 2007 16:39:42 +0100
Message-ID: <60E856FD577CC04BA3727AF4122D3F1601238653@3bit.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I've noticed strange problem,=20
With newer kernels 2.6.18, 2.6.19 when trying to load both Ethernet =
interfaces (for example root FS is mounted via NFS on eth0 and large =
TFTP file transfer is performed on eth1), the following happens:
- either ethernet throughput is drastically reduced, pings become 1-4s =
(on both interfaces), however everything works;
- or "NETDEV WATCHDOG: eth0: transmit timed out" happens. With debug on =
I see that drivers tries to recover from this, but with no success, the =
only way is to reboot board.=20

As I remember, in earlier kernels (2.6.11 for sure) it works. Also using =
only one interface at a moment, no problem (24h tests, 100's of gigabyte =
tranferred). =20

Any ideas/suggestions?

thanks in advance,
--
Andriy Korud
