Subject: Re: New TiPB - PCMCIA settings
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: George Staikos <staikos@kde.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1037695549.3241.479.camel@thor>
Mime-Version: 1.0
Date: 19 Nov 2002 09:45:50 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Die, 2002-11-19 at 00:29, George Staikos wrote:
>
> What doesn't work right now:
> - dmasound is aweful (lots of clicking and sounds bad)

With a current benh kernel? Do the latest TiBooks have different sound
hardware again?

> - video issues in XFree86 and fbdev, along with sleeping
>     - closing the screen causes lots of garbling on the screen.

Sleep doesn't even work with the 7500 Mobility yet, let alone the 9000
Mobility. Otherwise, people have reported moderate success with radeonfb
from the current benh tree and my DRI snapshot Debian packages.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
