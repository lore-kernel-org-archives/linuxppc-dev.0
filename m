Message-ID: <20010820025147.7057.qmail@kunk.jriver.com>
Subject: Re: Occasional crash reports
In-Reply-To: <20010818111705.1E2B2DB9D0@atlas.valhalla.net> "from Iain Sandoe
 at Aug 18, 2001 12:16:58 pm"
To: Iain Sandoe <iain@sandoe.co.uk>
Date: Sun, 19 Aug 2001 21:51:47 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Iain Sandoe says:
> >
> > Mace is still unreliable in 2.4. It's always been just plain unreliable
> > for me on 7200, 7500 and 7600's.
>
>  - are these clones or Apple originals?
> we found other dbdma problems on clone 7x00 machines for PowerComputing (in
> the sound side) ...

All are Apple originals.

> might be worth checking that there are no cases of "DEAD" status coming up
> on the Mace driver...

I am setting up a test machine as I write this. I'm setting up YDL 2.0
on a 7200 using the internal mace. I'll get it to fail (not hard) and
put some printk's in the "DEAD" tests in mace.c

> as I say, booting with the BootX *init* (rather than the application) bmac,
> at least, seems reliable on g3/beige (don't use Mace much).

Will check that as well and let you know.

> ciao,
> Iain.
>

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
