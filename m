Subject: Re: pbbuttons, need some help
From: Tuomas Kuosmanen <tigert@ximian.com>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: Matthias Grimm <joker@cymes.de>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020307134140.56d70400.jpgarcia@execpc.com>
References: <3C852E12.3030300@cymes.de>
	<20020306090814.15511@mailhost.mipsys.com> <3C87B6C8.9070905@cymes.de>
	<20020307134140.56d70400.jpgarcia@execpc.com>
Content-Type: text/plain
Date: 09 Mar 2002 16:43:42 +0200
Message-Id: <1015685023.2150.86.camel@quicksilver>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2002-03-07 at 21:41, Joseph P. Garcia wrote:

    Along those same lines, I have a sugesstion for the gtk client for
    pbbuttons.  The program should use the X keycodes rather than associate
    with the daemon that controls the hardware.  This serves two purposes: X
    handles any client/server mess, and the GUI will be the system independant
    figurehead it should be (IMO).  Bastien wrote a similar program that uses
    the keycodes, so it could be used on any system with the keys, even an x86.
    (hadess.net)

Now, I dont know if this is a problem or not but please note that the
"dim the lcd after inactivity" -kind of stuff should not rely on X
screen being active. I mean, if I use MOL for example the keyboard
activity happens on the console - resulting a dimmed display in a moment
if one monitors for X keyboard stuff. Which is rather annoying.

Best,

Tuomas

--
:: :: Tuomas Kuosmanen  :: Art Director, Ximian :: ::
:: :: tigert@ximian.com :: www.ximian.com       :: ::


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
