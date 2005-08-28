Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-230-sunday.dmz.nerim.net
	[195.5.254.230]) by ozlabs.org (Postfix) with ESMTP id 2C4F8680DD
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 04:43:29 +1000 (EST)
Received: from kraid.nerim.net (smtp-100-sunday.nerim.net [62.4.16.100])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 932703ACC6
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Aug 2005 20:16:55 +0200 (CEST)
Date: Sun, 28 Aug 2005 20:17:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andreas Schwab <schwab@suse.de>
Message-Id: <20050828201706.07660a62.khali@linux-fr.org>
In-Reply-To: <jehdda2tqt.fsf@sykes.suse.de>
References: <jehdda2tqt.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andreas, all,

> The last change to drivers/pci/setup-res.c (Ignore disabled ROM
> resources at setup) is breaking radeonfb on iBook G3 (with Radeon
> Mobility M6 LY). It crashes in pci_map_rom when called from
> radeonfb_map_ROM.  This is probably a dormant bug that was just
> uncovered by the change.

FWIW, it didn't seem to break my Sony Vaio PCG-GR214EP (x86 with Radeon
Mobility M6 LY as well.) So it must be machine-specific, not
chip-specific.

-- 
Jean Delvare
