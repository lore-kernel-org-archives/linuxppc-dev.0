Date: Fri, 14 Nov 2003 12:17:35 +0100
From: Wilmer van der Gaast <lintux@lintux.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Oops in current linux-2.5-benh
Message-ID: <20031114111735.GA13590@gaast.net>
References: <20031114011048.GG24030@gaast.net> <1068793571.9828.40.camel@gaston>
Mime-Version: 1.0
In-Reply-To: <1068793571.9828.40.camel@gaston>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> Does it happen if you built i2c in the kernel instead of as a module ?

It already was in the kernel (except for keywest), but somehow it
managed to load the i2c-core module anyway.

This was possible because linux-2.6.0-test9 (also on my machine) had its
modules in /lib/modules/2.6.0-test9 as well. I added -benh to the
EXTRAVERSION in linuxppc and recompiled/-installed the whole
kernel+modules. Isn't it better to keep that in EXTRAVERSION on the
bk/rsync source as well?

Anyway, it certainly looks a lot better now!!! aumix works (didn't work
in -test9), and even sleeping works! (I'd never seen that working in
Linux before)

This is fantastic. Okay, thanks. Keep up the good work, 2.6-benh works
better for me than 2.4-benh already.

By the way, not really on-topic, but I'm probably not the first to see
this problem: The UTF8 stuff in 2.6 breaks linedrawing chars and makes
almost every curses application ugly and unusable. What to do about
that?

Wilmer van der Gaast.

--
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
