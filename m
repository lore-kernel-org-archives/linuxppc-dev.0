From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "GRAVE Xavier" <grave@ipno.in2p3.fr>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 18:31:30 +0200
Message-Id: <20021022163130.5160@192.168.4.1>
In-Reply-To: <Pine.OSF.3.91.1021022160554.3474A-100000@ipnosl.in2p3.fr>
References: <Pine.OSF.3.91.1021022160554.3474A-100000@ipnosl.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Yah, though XFree CVS should work, and Michel Danzer debs
>> might too, but that has to be tested with him.
>I'll try them in a few minutes...
>> What about radeonfb ? (The kernel framebuffer device). Does
>> it work with my kernel ?
>
>It is in the kernel, but how do you now it work ?
>
>I have the two penguin at start.

Ok, if you have the penguins and the text console, then it
works.

>But I don't know how to make xfree86 to use radeonfb.

Use "fbdev" as the driver in xfree, that will cause X to
run unaccelerated on top of radeonfb, so it will at least
be able to set mode & colors properly.

I think support for the 9000 have been added to XFree CVS
recently, though that may not yet be in the DRI one (and
so Michel snapshots). The XFree CVS is beeing merged
again into the DRI one now, so this should be fixed soon.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
