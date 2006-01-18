Return-Path: <frank@scirocco-5v-turbo.de>
Received: from hermes.frankfurt.de.velia.net (hermes.frankfurt.de.velia.net
	[85.195.64.15]) by ozlabs.org (Postfix) with ESMTP id 76756689DA
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 01:30:41 +1100 (EST)
Subject: Re: Feedback: Support for fn key on Apple PowerBooks
From: Frank Arnold <frank@scirocco-5v-turbo.de>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20060118112049.GA32634@hansmi.ch>
References: <1137580063.3466.134.camel@localhost>
	<20060118112049.GA32634@hansmi.ch>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 15:30:33 +0100
Message-Id: <1137594633.3466.151.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Mittwoch, den 18.01.2006, 12:20 +0100 schrieb Michael Hanselmann:
> On Wed, Jan 18, 2006 at 11:27:43AM +0100, Frank Arnold wrote:
> > I have some trouble with it. Actually, the mapping of function keys F1
> > to F10 seems to be inverse. I have to press fn + function key to get a
> > plain function key event. Pressing a function key only gives me those
> > fancy new keycodes for brightness, mute, and so on. Page up, Page down,
> > Home, and End are working like expected.
> 
> Mac OS X behaviour (default):
> echo 1 > /sys/modules/usbhid/parameters/pb_fnmode

Thank you, now I've got it.

I never really used Mac OS X and didn't know about this behavior.
Personally I would prefer fkeysfirst as default setting. It's much more
sane on Linux because function keys are frequently used in different
applications. I nearly break my fingers when trying to get to the GNOME
main menu with fkeyslast.

Anyway, perhaps I'm biased. I can live with both, now that I know where
to set it.

Frank
