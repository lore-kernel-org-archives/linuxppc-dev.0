Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id BFACE67B31
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 03:37:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 8 Apr 2005 19:36:28 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D39@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Are you running this via a ramdisk or nfs?  If ramdisk can you post it

> somewhere that I can get to?

I'm running via NFS.

> Also, can you email the list with the kernel oops that shows up.

I'll do that next week.

Anyway, reading the source suffices to realize there's a problem when=20
MATH_EMULATION is disabled on a FPU-less system with user programs=20
using load/store fp instructions.

--=20
Stephane
