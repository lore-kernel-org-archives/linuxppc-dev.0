Message-ID: <20001212140752.4814.qmail@kunk.jriver.com>
Subject: Re: 2.2.18 release version
In-Reply-To: <19341106051608.18575@192.168.1.2> "from Benjamin Herrenschmidt
 at Dec 12, 2000 12:44:24 pm"
To: Benjamin Herrenschmidt <bh40@calva.net>
Date: Tue, 12 Dec 2000 08:07:52 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
CC: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Benjamin Herrenschmidt says:
> >It does not however have Michel Lanners controlfb dma patch and
> >memory detection fix. I suppose we'll have to hand patch that till
> >2.4
>
> I must have missed something... I never saw a "dma" patch for controlfb.
> I did see a patch to make use of caching and this patch is in 2.4.
>
> I didn't want to flood 2.2.18 with too much patches since there was
> already a great bunch of them that went in and it needed to stabilize.
> 2.2.19 will have room for now stuffs however.

Sorry, I must have DMA on the brain, I messed this up before as well.
I meant MMAP (caching).

The MMAP patch and the video memory detection changes make the controlfb
driver MUCH more useful. The speed increase is very noticable and the
memory detection change allows use of 32 bit depth at 1024x768

Bob

--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
