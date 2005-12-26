Return-Path: <dtor_core@ameritech.net>
Received: from smtp111.sbc.mail.re2.yahoo.com (smtp111.sbc.mail.re2.yahoo.com
	[68.142.229.94]) by ozlabs.org (Postfix) with SMTP id AC45468911
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Dec 2005 15:04:37 +1100 (EST)
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Date: Sun, 25 Dec 2005 23:04:30 -0500
References: <20051225212041.GA6094@hansmi.ch>
In-Reply-To: <20051225212041.GA6094@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512252304.32830.dtor_core@ameritech.net>
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

On Sunday 25 December 2005 16:20, Michael Hanselmann wrote:
> This patch adds a basic input hook support to usbhid because the quirks
> method is outrunning the available bits. A hook for the Fn and Numlock
> keys on Apple PowerBooks is included.

Well, we have used 11 out of 32 available bits so there still some
reserves. My concern is that your implementation allows only one
hook to be installed while with quirks you can have several of them
active per device.

As far as the hook itself - i have that feeling that it should not be
done in kernel but via a keymap.
 
-- 
Dmitry
