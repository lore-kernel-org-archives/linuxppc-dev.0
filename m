Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id ADBA4DDFAD
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 01:17:01 +1000 (EST)
Date: Thu, 18 Sep 2008 19:16:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] Patches to support QE USB Host Controller
Message-ID: <20080918151659.GA20140@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

More than a month has passed since the first post. Unfortunately
David didn't comment on the "1/3" patch, and Greg said that he
have to wait for it...

(Laurent Pinchart also said that he is interested in the first
patch, so here are at least two users for that call.)

So I'm reposting this again. The first patch has changed in a way
that now it exports gpio_desc instead of just a function, this keeps
the gpiolib code optimized.

Previous patchset and discussion can be found here:

http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-08/msg03687.html


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
