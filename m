To: Stefan Wanner <stefan.wanner@gmx.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: invert lcd on mpc823l 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Oct 2001 11:19:00 +0200."
             <3BD3E484.1030909@gmx.ch>
Date: Mon, 22 Oct 2001 11:24:41 +0200
Message-Id: <20011022092446.E745010CD6@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BD3E484.1030909@gmx.ch> you wrote:
>
> i'm using a sharp LQ64D341 tft lcd on a MPC823L board with the

Is this a custom board, or some standard product?

> kernelsources from denx.de. now when i use /dev/tty0 (the frambuffer
> character device) the output apears inverse (white background, black
> text). the tux in the upper left corner has also strange colors (looks
> also like inverse). how can i fix that?

Are you sure that all wires are connected properly?

Works here - on a TQM823L-E.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
What can it profit a man to gain the whole world and to come  to  his
property with a gastric ulcer, a blown prostate, and bifocals?
                                     -- John Steinbeck, _Cannery Row_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
