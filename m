Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40E514DE.6020300@iti.fi>
Date: Fri, 02 Jul 2004 10:55:10 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Stefan Nickl <Stefan.Nickl@kontron.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working
References: <20040702072211.901A5C109F@atlas.denx.de>
In-Reply-To: <20040702072211.901A5C109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <40E4E804.5010606@iti.fi> you wrote:
>
>
>>Do you meaean that responsibility of byte order is left to application
>>level ?
>>
>>
>
>No. The graphic drivers are responsible for it.
>
>
It is how you call it. X server or Embedded QT graphics driver normally
works
in user level..

>>Linux fbdev just maps display memory to user application space and so it
>>cant do anything for how R,G,B bits are ordered within word. It is
>>then responsibility to GUI-engine ( X-server, Embedded-QT ) to
>>handle this ordering.
>>
>>
>
>This is why it is impossible to use a simple  framebuffer  driver  on
>the  Coral-P  in  16  bit mode. You can run a framebuffer with 24 bpp
>(and actually our first demo dreiver was doing this), but it ain't no
>fun.
>
>
Yes, this was that i were using and in this one x-server was just
patched to fix byte order.

>Also, with  a  framebuffer  driver  you  miss  all  the  options  for
>accelerated graphics provided by the Coral-P engine.
>
>This is why we implemented an accelerated X11 driver for the Coral-P.
>
>
I should try this new one. With the older one i have some problems with
get all required
virtual console etc drivers to compiled to kernel to make Xfree 4.4
happy. Ok, now
there looks a like to be icecube_5200_CoralP_defconfig

It is just somehow dificult to find all new files appearing to tree ......

May be it is worth to try use QT with X11 server instead using embedded
qt direct to
fb device. In older driver it was anyhow much better to use embedded qt
direrctly.



Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
