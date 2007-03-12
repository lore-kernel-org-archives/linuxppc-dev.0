Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 367DCDDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:41:08 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:02 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 00/19] bootwrapper/cuImage patches
Message-ID: <20070312204102.GA28478@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've rebased the bootwrapper changes onto David Gibson's March 5th
bootwrapper patches 6, 7, and 8 (zImage: Add more flexible gunzip
convenience functions, zImage: Cleanup and improve prep_kernel(), and
zImage: Cleanup and improve zImage entry point).

I've also addressed some concerns that were raised since the last
patchset I posted.

I've tested it on an MPC8313 and a G4 PowerMac.  I've tested it with a
VPATH, and the dtb is correctly created in the output directory.

Paul, please apply the above prerequisite patches and this patchset for
2.6.22 if there are no objections this time.

-Scott
