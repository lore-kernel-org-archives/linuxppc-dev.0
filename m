Message-ID: <399A5D88.1535C44C@relog.ch>
Date: Wed, 16 Aug 2000 11:23:20 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: MkLinux Setup List <mklinux-setup@public.lists.apple.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Xlib Question
References: <Pine.LNX.3.96.1000815163648.21337B-100000@deepspace.mklinux.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David A. Gatwood" wrote:

> When I'm running a multithreaded app with heavy signal load,

...like Netscape? :)

> xlib messages stop being delivered from xlib to the program, resulting in
> XNextEvent stalling.  Most of the time, if you click somewhere in that
> window, those events all get delivered at once, sometimes twenty or thirty
> at a time.

I've noticed that Netscape often stalls up/downloads to/from the roaming
access server. When I click into the window, it continues. Is that the problem
you are seeing as well?

It happens to me on both powerpc and i386, with both 2.2 and 2.4 kernels, and
I use 3.3.x X libraries.

This makes me suspect the 4.0.1 server (I don't remember it happening with
4.0), are you using that as well?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
