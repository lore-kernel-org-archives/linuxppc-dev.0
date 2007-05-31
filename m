Return-Path: <mgreer@mvista.com>
Date: Thu, 31 May 2007 12:51:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/3] powerpc: Clean up some boot/Makefile rules
Message-ID: <20070531195136.GA3699@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Gibson <dgibson@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch series removes the 'make zImage.dts' feature that was recently
added.  Its been replaced by some logic that will automaticaly wrap a dts
with the zImage when CONFIG_WANT_DEVICE_TREE is 'y' and CONFIG_DEVICE_TREE
isn't an empty string.  Otherwise, things will work as they always have.
A patch to update the holly to use this support (i.e., remove the extra
Makefile rules) is included as well.

Please let me know if you have any issues with these patches.

Thanks,

Mark
