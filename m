Return-Path: <schwab@suse.de>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 578BB2BDB5
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jan 2005 07:11:43 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 31 Dec 2004 20:43:22 +0100
Message-ID: <jeis6ijlt1.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Radeon blanking broken
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The radeonfb blanking rework has broken it on the iBook G3 wit Radeon M6.
When the X server enables DPMS the backlight stays on and the display gets
in a strange state, gradually fading off.  When I revert the changes to
radeon_screen_blank, radeonfb_blank and radeon_set_backlight_enable it
works again.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
