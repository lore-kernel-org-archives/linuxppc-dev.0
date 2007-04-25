Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 16:46:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/13] powerpc: Add support for Marvell/mv64x60 and prpmc2800
Message-ID: <20070425234630.GA4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following set of patches add support for the Motorola prpmc2800/f101e platform.
To support that platform, several other patches are required that can be grouped as
follows:

	- 1 patch to add Makefile rules that automatically compile & wrap a dts into
	  a zImage
	- 1 patch to add a new interface to the dt_xlate code.
	- 3 mv64x60 bootwrapper patches
	- 5 mv64x60 kernel patches
	- 3 prpmc2800 patches

Mark
