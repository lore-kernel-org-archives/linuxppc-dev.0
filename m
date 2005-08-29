Return-Path: <alex.williamson@hp.com>
Received: from mailhub.hp.com (mailhub.hp.com [192.151.27.10])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mailhub.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 34CC668109
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 14:25:17 +1000 (EST)
From: Alex Williamson <alex.williamson@hp.com>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jehdda2tqt.fsf@sykes.suse.de>
References: <jehdda2tqt.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 22:02:55 -0600
Message-Id: <1125288175.5595.3.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Sun, 2005-08-28 at 13:20 +0200, Andreas Schwab wrote:
> The last change to drivers/pci/setup-res.c (Ignore disabled ROM resources
> at setup) is breaking radeonfb on iBook G3 (with Radeon Mobility M6 LY).
> It crashes in pci_map_rom when called from radeonfb_map_ROM.  This is
> probably a dormant bug that was just uncovered by the change.

   Same thing on Mac Mini.  2.6.13 doesn't boot.  Revert the
drivers/pci/setup-res.c change from rc7-git2 and it seems ok.

	Alex
