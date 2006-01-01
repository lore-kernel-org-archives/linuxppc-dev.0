Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4B21768900
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Jan 2006 12:33:47 +1100 (EST)
Date: Sun, 1 Jan 2006 02:33:43 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Message-ID: <20060101013343.GA19703@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<20051231235124.GA18506@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051231235124.GA18506@hansmi.ch>
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 01, 2006 at 12:51:24AM +0100, Michael Hanselmann wrote:
> +#define HID_QUIRK_POWERBOOK_NUMLOCK_ON		0x0002000

Aww, please ignore that one when looking at the patch. It's not used and
I'll resubmit the patch anyway with a full Signed-off-by & Co. once you
approve it.

Greets,
Michael
