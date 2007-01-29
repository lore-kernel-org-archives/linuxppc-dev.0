Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3A3B3DE242
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:15:21 +1100 (EST)
Date: Sun, 28 Jan 2007 21:21:43 -0600
To: paulus@samba.org
Subject: [PATCH] [0/4] PMC-related cleanups [v2]
Message-ID: <20070129032143.GC6412@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following short series contains a few patches to abstract and clean
up some of the PMC handling on powerpc, followed by the introduction of
the sysfs support for PMCs on PA6T.

Edits since last submit:

* Setting .owner in the sysdev_attr patch
* Using intvec_top instead of intvec_base for setting "soft" vectors
* Fix patch badness with duplicate .pmc_type for one entry


Thanks,

Olof
