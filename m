Date: Tue, 26 Sep 2000 21:51:50 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Olaf Hering <olh@suse.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <20000926213226.B9861@suse.de>
Message-ID: <Pine.LNX.4.10.10009262147250.21736-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > I have a precompiled benh Kernel at penguinppc.org/~olaf with Benhs current
> > > kerneltree, your patch is still needed - otherwise *kaboom*
> >
> > No surprise there. But I don't consider the patch clean enough for
> > inclusion with the 2.2 kernels, at least not without safeguarding that the
> > guessed PCI region isn't occupied.
>
> Yes, it might not be a candidate for kernel.org, but for the local
> kernel tree to allow XF4 on the PowerBooks. However, Anis driver works

I've only tested it on one machine, I have no idea what it does on some of
the less common ones. I'll try to implement the safeguard and send it to
Paul and BenH after that.
I'm out of the office until next week so it won't happen fast.

> so far. But if you do a cold boot on the iBook as example some KDE
> windows are screwed up, like the "could not open mixer" after a login.
> If you boot in MacOs once and reboot into Linux it works again, looks
> like an setup problem. I have that on all ati based machines here,
> iBook, a beige G3 and the Wallstreet. I boot with miboot most of the
> time.

Looks like we should compare the state the card is left in by MacOS and
what we get from a cold boot (I know this is non-trivial) instead of using
the 'boot MacOS first' workaround.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
