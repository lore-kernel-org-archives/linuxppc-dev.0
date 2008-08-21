Return-Path: <bounces@nabble.com>
Message-ID: <17508718.519751219361767598.JavaMail.nabble@isper.nabble.com>
From: lim.chongkean@gmail.com
To: Linuxppc-embedded@ozlabs.org
Subject: About physmap driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Aug 2008 16:36:07 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

when i try to do the following on the target system:

cat /proc/mtd
dev:    size   erasesize  name
mtd0: 04000000 00020000 "physmap-flash.0"

no partition is showing,
i've enabled the MTD partition support in make menuconfig.

appreciate for any guide out there. 
