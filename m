Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id EB237DDE1A
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 01:02:44 +1000 (EST)
From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@tungstengraphics.com>
To: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 0/2] Add support for Apple aluminum USB keyboards
Date: Sat, 13 Oct 2007 16:37:23 +0200
Message-Id: <1192286246-11489-1-git-send-email-michel@tungstengraphics.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
	mactel-linux-devel@lists.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series of two patches adds support for Apple aluminum USB
keyboards to the hid and usbhid modules. The first patch contains no functional
change but just renames code identifiers, the second patch adds the actual
support by reusing and extending the existing quirks for Apple laptop USB
keyboards.

There's some things I'm not too sure about and would appreciate suggestions
for, e.g.

* The keycodes generated for the Exposé and Dashboard keys.
* Whether F5 and F6 should be subject to the pb_fn_mode option even though they
  don't have any special engravings.
* I only have an ISO keyboard, so the device IDs for the ANSI and JIS variants
  are guessed from the previous models.
