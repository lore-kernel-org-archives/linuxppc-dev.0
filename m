To: "=?iso-8859-1?Q?Raphael_Ertle?=" <raphael.ertle@laposte.net>
Cc: "=?iso-8859-1?Q?linuxppc-embedded?=" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: =?iso-8859-1?Q?Cybook_-_MPC823e?= 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Nov 2003 17:46:03 +0100."
             <HOK3WR$C21EDB61D2D1F124670DB50B6D1D2D73@laposte.net>
Date: Tue, 18 Nov 2003 22:46:40 +0100
Message-Id: <20031118214645.E201DC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Raphael,

in message <HOK3WR$C21EDB61D2D1F124670DB50B6D1D2D73@laposte.net> you wrote:
>
> BUT, there does not seem to be any JTAG connector or anything
> else (it's not a development board), and I don't have neither
> the skills nor the material to re-flash anything.

Are you sure there is no BDM  connector  somewhere  (or  10  "unused"
solder pads or so) ?

> What I wonder is if it is possible to wire some JTAG connector

It depends. Ir may be possible, or may be not  (some  may  be  hidden
under  the  CPU,  and there is no way to contact themin such a case).
And it depends on how much effort you put into this - and if the  box
is worth such an effort.

> (I guess pins must exist, and if yes how may I find them), or
> if there may be an other way to load something like an other
> system. I have really no access to the underlying OS (no magic
> key combination, no magic reset, ...), so I guess it can only
> be done "hard".

Without a detailed hardware documentation (read:  schematics)  and/or
sources  for  the existing software it will be definitely non-trivial
to get anything else running on such a board.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
f u cn rd ths, u cn gt a gd jb n cmptr prgrmmng.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
