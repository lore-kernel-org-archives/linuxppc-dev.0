Mime-Version: 1.0
Message-Id: <p05101000b81dd161fddc@[10.0.0.42]>
In-Reply-To: <20011118174724.HJSA24249.tomts11-srv.bellnexxia.net@there>
References: <20011118174724.HJSA24249.tomts11-srv.bellnexxia.net@there>
Date: Sun, 18 Nov 2001 13:28:57 -0800
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: How to control Brightness for Flat Panels?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:50 PM -0500 11/18/01, Kevin B. Hendricks wrote:
>Hi,
>
>How do we go about controlling "brightness" for Flat Panels?  Is this
>functionality in the radeonfb.c or the XFree86 code?
>
>The new Apple FlatPanels has no manual brightness knob or control so it
>must be done in software.
>
>Ideas anyone?

For Apple's monitors this might actually happen through USB.  ADC has
it, and it would be a handy data path to use for such commands.  The
fact that MacOS 9 has a "USBAppleMonitorModule" extension and MacOS X
has "AppleUSBDisplays.kext" is suggestive.

If it is in fact USB, you could probably write a userspace program
(using libusb) without touching XFree86 or radeonfb at all.  The
tough part would be deciphering the protocol.  (Pretty easy if you
have a USB protocol analyzer to watch what MacOS does.)
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
