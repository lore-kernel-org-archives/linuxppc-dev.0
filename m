Date: Thu, 21 Sep 2000 19:52:51 -0400 (EDT)
From: James Simmons <jsimmons@acsu.buffalo.edu>
To: Paolo Scaffardi <arsenio@tin.it>
cc: linuxcon <linuxconsole-dev@lists.sourceforge.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Custom serial keyboard: playing dirty with the serial console
In-Reply-To: <002801c02314$eb3c75a0$0a00010a@paoloweb>
Message-ID: <Pine.LNX.4.10.10009211943580.437-100000@maxwell.futurevision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> But 'handle_scancode' only prints characters to the console, without
> apparently processing them. I see everything i write, but when i press
> enter (scancode 0x1c), i only see a new line in the console, not any new
> bash prompt.

Hum? Try running the program showkey. It prints out the key codes for the
keys you press. Can you post the results. If you are translating the codes
into XT scancodes then it shpould make what I get with showkey. BTW make
sure  you tell me what keys you pressed.


P.S.

  As I move to californis these next 2 weeks my email service will be
switching. This means I will not be able to read my email from  Friday
until October 2.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
