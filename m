Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id D6D0267B16
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 22:15:21 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by mail.skekraft.net (Postfix) with ESMTP id 2DC0FA4005
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 14:15:16 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Setting I&D cache enable in the same mtspr instruction
Date: Mon, 29 May 2006 14:15:14 +0200
References: <B9FFC3F97441D04093A504CEA31B7C41A62B2F@msilexch01.marvell.com>
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41A62B2F@msilexch01.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200605291415.14908.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is the patch reversed?

diff -Naur old new > patch

And what about comments, are they all still valid?
"enable and invalidate caches" is now only Data cache...

In cases when I am writing code like this I try to
include the reason why it is not "optimized" together
in one write... (or soon someone will do that optimization).

/RogerL
