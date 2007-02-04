Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A8948DDEC1
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 09:41:51 +1100 (EST)
Message-Id: <20070204223648.767950000@lixom.net>>
Date: Sun, 04 Feb 2007 16:36:48 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [v2] [0/8] PA Semi patches
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series fills in a lot of the missing pieces from the PA
Semi platform. In addition to these ones, the smbus and ethernet drivers
have been posted on their respective lists and are queued for 2.6.21.

These are meant to be applied on top of the PMC cleanups that were posted
earlier (Subject: PMC-related cleanups [v2]).

Changes since last post:

* Dropped the root device setting patch
* Now using ppc_md.power_save instead of copying the whole idle loop
  setup
* Doing the SDC register ioremap in setup instead of at reboot time
* A couple of minor typos/comment updates

Paul, please consider these for the 2.6.21 merge window.

Thanks,

-Olof
