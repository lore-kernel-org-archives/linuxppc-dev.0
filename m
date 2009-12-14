Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3FA3BB6EEE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 02:40:28 +1100 (EST)
Date: Mon, 14 Dec 2009 18:40:25 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH v2 0/2] USB: ehci-fsl: Power management support
Message-ID: <20091214154025.GA24035@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>,
	Jerry Huang <Chang-Ming.Huang@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

The patches were waiting for commit 2e9d546eda5888962a441da1e96bbf9
("powerpc/fsl: Make fsl_deep_sleep() usable w/ modules and non-83xx
builds") to hit Linus' tree.

Now that the commit is in, I'm resending the series with some
corrections as suggested[1] by Scott Wood.

It might be late for 2.6.33, but I believe that the patches are
actually quite safe.

Thanks!

[1] http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg37297.html

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
