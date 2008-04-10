Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id DBB04DE156
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:22:15 +1000 (EST)
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com
	[128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m3ANMDGe017228
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 16:22:13 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] Support for Wind River SBC8641D board
Date: Thu, 10 Apr 2008 19:22:16 -0400
Message-Id: <1207869739-19892-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following patches add support for the Wind River SBC8641D board.
I've done it by starting with the current mpc8641_hpcn support and
then making the changes from there, so it should be 1:1 comparable
with the HPCN platform, which aids in tracking/applying future changes.

The SBC8641D support essentially boils down to trimming back stuff
from the HPCN platform, as this board doesn't have the Uli and all
the devices/busses etc. that the HPCN cascades from that.  Plus of
course, the dts changes for the localbus specifics.

Patches that aren't included here, but submitted separately are the
support for the Broadcom 5464 quad PHY and the ability to have the
Gianfar TBIPA be auto assigned (since this board puts a PHY at 0x1f).

I expect the defconfig will probably be in an 86xx subdir, based on
what Kumar sent today, but for now it is still in configs.  I'm hoping
to see this queued up for 26, if all goes well.

Thanks,
Paul.
