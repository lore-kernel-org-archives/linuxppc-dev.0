Message-ID: <20001120050245.2300.qmail@kunk.jriver.com>
Subject: Re: controlfb and X (fixed)
In-Reply-To: <200011191036.LAA00685@piglet.grunz.lu> "from Michel Lanners at
	Nov 19, 2000 11:36:30 am"
To: mlan@cpu.lu
Date: Sun, 19 Nov 2000 22:39:44 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
CC: linuxppc-devel@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Michel Lanners says:
>
> > Which 2.4.0 kernel source are YOU using?
>
> I'm running BenH's 2.5 kernel, that's the only one I was able to boot on
> my 7600. Paulus' 2.4 kernels lock my machine 90% of the time at boot. I
> haven't found what's wrong with them, though...
>
> BenH's kernel is at:
>
> rsync -arvz penguinppc.org::linux-benh-devel .
>
> Happy compiling ;-)

FINALLY got the 2.4.0-test10 benh kernel going.
I had to turn off a bunch of stuff to get it to run (i.e. to avoid
the black screen of death on boot) and I'm not sure the
PPP async driver works yet, had to compile it as a module.

The controlfb driver now senses the 4m video memory properly
on the 7500.

XFree4.01 runs (though the keyboard is messed up. I have to investigate
the new input layer)

The stock XFree86 (XFree86-3.3.6-11.2) also works in 24/32 bits now!!!
HOORAY!! Hopefully the changes will eventually make it to the stock
trees.

Thanks Michel!

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
