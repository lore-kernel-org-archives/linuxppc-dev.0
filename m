To: Kate Alhola <kate@iti.fi>
Cc: Stefan Nickl <Stefan.Nickl@kontron.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Jul 2004 07:43:48 +0300."
             <40E4E804.5010606@iti.fi>
Date: Fri, 02 Jul 2004 09:22:06 +0200
Message-Id: <20040702072211.901A5C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40E4E804.5010606@iti.fi> you wrote:
>
> Do you meaean that responsibility of byte order is left to application
> level ?

No. The graphic drivers are responsible for it.

> Linux fbdev just maps display memory to user application space and so it
> cant do anything for how R,G,B bits are ordered within word. It is
> then responsibility to GUI-engine ( X-server, Embedded-QT ) to
> handle this ordering.

This is why it is impossible to use a simple  framebuffer  driver  on
the  Coral-P  in  16  bit mode. You can run a framebuffer with 24 bpp
(and actually our first demo dreiver was doing this), but it ain't no
fun.

Also, with  a  framebuffer  driver  you  miss  all  the  options  for
accelerated graphics provided by the Coral-P engine.

This is why we implemented an accelerated X11 driver for the Coral-P.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Today is the yesterday you worried about tomorrow.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
