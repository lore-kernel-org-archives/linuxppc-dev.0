Date: Wed, 3 Jan 2001 16:10:17 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound and 2.2's dmasound
In-Reply-To: <200101031947.TAA19299@hyperion.valhalla.net>
Message-ID: <Pine.LNX.4.21L.0101031559140.1374-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 3 Jan 2001, Iain Sandoe wrote:
>
> > - the 2.4 dmasound backport doesn't work compiled in (and probably could be
> >   updated for 2.2.18)
>
> it's probably a silly - like forgetting to call the init from within
> drivers/char/mem.c  (that change has been made several times by both me &
> Geert) but it seems to slip out of the diffs somehow)...

There is (among other things)

+#ifdef CONFIG_DMASOUND_AWACS
+       dmasound_awacs_init();
+#endif

in char/mem.c...

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
