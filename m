Return-Path: <machek@atrey.karlin.mff.cuni.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193]) by ozlabs.org (Postfix) with ESMTP id 52CA1B7D1E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 03:06:01 +1100 (EST)
Date: Tue, 9 Feb 2010 16:24:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	kernel list <linux-kernel@vger.kernel.org>
Subject: register long sp asm("r1") incorrect
Message-ID: <20100209152444.GA30176@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


...according to gcc docs, sp should be global, or placement in
register is not guaranteed (except at asm boundaries, but there are
none).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
