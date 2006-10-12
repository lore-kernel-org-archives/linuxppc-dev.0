Return-Path: <michael@ozlabs.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 12 Oct 2006 22:03:07 +1000
Subject: [PATCH 0/2] Cell xmon helpers
Message-Id: <1160654587.449977.520618728447.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following two patches add three commands to xmon for stopping,
restarting and dumping info about spus from xmon.

For the folks on linuxppc-dev, these patches depend on another patch
which isn't in the powerpc tree yet AFAIK, you can get it here:
http://kernel.org/pub/linux/kernel/people/arnd/patches/2.6.17-arnd8/broken-out/spu-add-attributes.diff

cheers
