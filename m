To: "Mike O'Brien" <mobrien@airfiber.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in Init 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 01 Aug 2001 11:01:59 PDT."
             <000101c11ab4$0fc48f60$6865a8c0@airfiber.com>
Date: Wed, 01 Aug 2001 20:37:57 +0200
Message-Id: <20010801183803.09CD210CAF@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000101c11ab4$0fc48f60$6865a8c0@airfiber.com> you wrote:
>
> I have been trying to get a custom PPC860 board up using MonteVista's Hard
> Hat
> 2.0 distribution using a vxWorks bootrom.  I have made alot of progress in
> the last
> few days but have got stuck at the point here init is executed.  The IMMR is
> set
> to 0x02200000.  I ran across some old posts on the list referring to this
> being set
> too low for linux.  Could this be the problem?  If not does anyone have any

Sure. Your system will crash as soon as the first  user-land  program
is running.

See http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO-10.html#ss10.2

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The algorithm to do that is extremely nasty. You might want  to  mug
someone with it."                   - M. Devine, Computer Science 340

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
