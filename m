Return-Path: <frank@scirocco-5v-turbo.de>
Received: from hermes.frankfurt.de.velia.net (hermes.frankfurt.de.velia.net
	[85.195.64.15]) by ozlabs.org (Postfix) with ESMTP id 3919D681BB
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2006 21:53:35 +1100 (EST)
Received: from p213.54.136.194.tisdip.tiscali.de ([213.54.136.194])
	by hermes.frankfurt.de.velia.net with esmtpa (Exim 4.50)
	id 1EzAXd-0008Mz-Ht
	for linuxppc-dev@ozlabs.org; Wed, 18 Jan 2006 11:27:49 +0100
Subject: Feedback: Support for fn key on Apple PowerBooks
From: Frank Arnold <frank@scirocco-5v-turbo.de>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 18 Jan 2006 11:27:43 +0100
Message-Id: <1137580063.3466.134.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

finally this patch seems to have made it into recent Fedora Rawhide
kernel. Thanks for your work.

I have some trouble with it. Actually, the mapping of function keys F1
to F10 seems to be inverse. I have to press fn + function key to get a
plain function key event. Pressing a function key only gives me those
fancy new keycodes for brightness, mute, and so on. Page up, Page down,
Home, and End are working like expected.

My system: PowerBook5,6 (vendor id 0x020F)
Kernel: 2.6.15-1.1858_FC5, as per Changelog 2.6.15-git12

-- Frank
