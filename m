Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 8D9B2DE471
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:41:05 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] Support for Wind River SBC8641D board
Date: Tue, 15 Apr 2008 18:41:29 -0400
Message-Id: <1208299292-21937-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


All the updates based on the feedback from folks (thanks!) are integrated
into this resend.  This should be good to go for powerpc-next/2.6.26.

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
Both of these are on track for being part of 2.6.26 already.

Thanks,
Paul.
