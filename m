Date: Fri, 25 Aug 2000 12:52:50 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: sprenger <sprenger@in.tum.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: xf4 and lombard
In-Reply-To: <39A5E3F7.1030409@in.tum.de>
Message-ID: <Pine.LNX.4.10.10008251249380.6415-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> using a 2.2.17pre15 worked fine, but with a 2.4-test6 kernel the
> x-server crashed often especially under heavy load - like compiling
> mozilla-m17 !? but even on the console the build would stop three times
> with error 132, just had to restart the build - strange .
> i just upgraded to 2.4-test7, and the x-server seems to be stable now
> (compiling a new mozilla while using the old one - really a heavy load
> ...). but now i have some garbage (several blue dots) on my screen,
> especially on the "gkrellm"-window.
> any idea ?

No, I don't do 2.4 (too much work to do in 2.2 yet).

> by the way, do you know the standard key-combination to emulate the
> second and third mouse button ? with the 2.4-test6 they used to be
> "fn-ctrl" and "fn-alt". but when i upgraded to 2.4-test7 i could not
> find them anymore.

Use showkey or xev. My emulation keys are F11 and F12, (108,111) in 2.2,
and as I said above, I don't bother too much with 2.4 as long as Linus
keeps doing these break-all-archs-except-i386 things to the code.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
