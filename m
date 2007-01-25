Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 62B54DE0E5
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 19:13:44 +1100 (EST)
Date: Thu, 25 Jan 2007 02:19:24 -0600
To: paulus@samba.org, gregkh@suse.de
Subject: [PATCH] [0/4] PMC-related cleanups
Message-ID: <20070125081923.GA10716@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
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

Greg, patch 3 in this series (the sysdev attribute one) is a prerequisite
for the one after. Would you mind ACKing it so Paul can feed it via his
tree so we can resolve this dependency?


Thanks,

Olof
