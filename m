Subject: Re: Lite5200 PCI not working
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040702072211.901A5C109F@atlas.denx.de>
References: <20040702072211.901A5C109F@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1089287836.6000.46.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Thu, 08 Jul 2004 13:57:17 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-07-02 at 09:22, Wolfgang Denk wrote:
> > Linux fbdev just maps display memory to user application space and so it
> > cant do anything for how R,G,B bits are ordered within word. It is
> > then responsibility to GUI-engine ( X-server, Embedded-QT ) to
> > handle this ordering.
>
> This is why it is impossible to use a simple  framebuffer  driver  on
> the  Coral-P  in  16  bit mode. You can run a framebuffer with 24 bpp
> (and actually our first demo dreiver was doing this), but it ain't no
> fun.

I now found out why my picture looked so dim...
My trusty old CRT was finally broken. ARG!

Ok, but the picture from the console (penguin, messages ...)
is still very blue-ish; however X is perfectly ok with
the accelerated driver, so with the above said by you,
it this what I have to expect?

I understand that console messages on the VGA are not
important for an embedded system when the apps (can)
work correctly.

I just want to avoid everyone asking me
"why does that screen look so blue?" :)

Btw: "fbset -depth 24" and bootargs+="video=mb86290:1024x768-24@70"
     apparently have no effect at all...


--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
