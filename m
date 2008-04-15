Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id C9BB4DED80
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 02:22:53 +1000 (EST)
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com
	[128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m3FGMpkd016085
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 09:22:51 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2.6.26 0/2] Dynamic TBIPA for gianfar
Date: Tue, 15 Apr 2008 12:23:19 -0400
Message-Id: <1208276601-16964-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is the resend of the two patches as per Andy's request for v2.6.26
that allow boards with a PHY at the end of the bus to function, by having
the TBIPA set dynamically.  The 1st patch factors out some of the PHY
probe code so it can be recycled by the TBIPA probe, and the second patch
implements the dynamic probe itself.

Paul.
