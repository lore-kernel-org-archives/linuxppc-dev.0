From: "Alan Wang" <wung_y@sina.com>
To: "Linuxppc-EmbeddedMaillist" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: how to configure LCD as console for RPX-LITE
Date: Sat, 21 Apr 2001 00:54:33 +0800
Message-ID: <EBEGJCKFJMJLDPEKGAKJCECCCAAA.wung_y@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <EBEGJCKFJMJLDPEKGAKJKEBNCAAA.wung_y@sina.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ok, I am working on hhl's 2.2.14. I enabled:
   Support for frame buffer devices (EXPERIMENTAL)
   RPX-Lite 823(e) LCD Frame Buffer
when I configured the kernel.

I am sure the lcd is configured correctly because I clear the screen by setting
the memory mapped to lcd's framebuffer to all zero after lcd823_init_dev(). but
nothing happened when the kernel boot, nothing displayed on the lcd.
I found lcd823_init() calls register_framebuffer() to do the registration, and
the console should be switched to frame buffer after register_framebuffer
call take_over_console(). but why there is no char displayed? any suggestion?
btw: do I have to enable "Advanced low level driver options"? the help file says
the low level drivers are automatically enabled.

thx
Alan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
