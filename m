Date: Sun, 28 Oct 2001 02:31:51 +0100
From: Stefan Pfetzing <dreamind@dreamind.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: iBook2 (and maybe more) special keys working
Message-ID: <20011028023151.C18032@server>
References: <3BDB409F.7010809@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BDB409F.7010809@hadess.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


* Bastien Nocera <hadess@hadess.net> [011028 01:17]:
>
> Hi,
Hi,
>
> After fiddling around, for much longer that it should have taken, it's
> there:
>
> http://hadess.net/files/ppc/hotkeys/
>
> I'd like to have some feedback, especially for other laptops. The Apple
> USB Pro Keyboard isn't supported yet because of an endianess bug in the
> USB keyboard driver... or so Franzo told me.
Well looks nice, I tried hotkeys some time ago but came to the point that the
keyevd2 (posted here some time ago) is signifficantly better cause it works
even when not within X :)
So i made a debian package out of it and changed several things.

use this for your sources.list:
deb http://www.dreamind.de/debian sid main
deb-src http://www.dreamind.de/debian sid main

this is no official debian package and its currently quite hacked... hope to
improve it in some days :)

bye


dreamind

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
