Date: Tue, 26 Sep 2000 21:32:26 +0200
From: Olaf Hering <olh@suse.de>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
Message-ID: <20000926213226.B9861@suse.de>
References: <20000926204606.B467@suse.de> <Pine.LNX.4.10.10009262125400.21452-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10009262125400.21452-100000@zirkon.biophys.uni-duesseldorf.de>; from schmitz@zirkon.biophys.uni-duesseldorf.de on Tue, Sep 26, 2000 at 09:27:02PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 26, Michael Schmitz wrote:

> > > I've posted such a patch to debian-powerpc when one user there had this
> > > problem. That was before I learned booting with yaboot avoids the problem.
> > > If the resource conflict also happens on oldworld machines, I'd still
> > > prefer some suggestions to foolproof the patch (as in: how can I figure
> > > out if a region has been allocated by another card? What bits from the
> > > config registers should I look at?).
> >
> > I have a precompiled benh Kernel at penguinppc.org/~olaf with Benhs current
> > kerneltree, your patch is still needed - otherwise *kaboom*
>
> No surprise there. But I don't consider the patch clean enough for
> inclusion with the 2.2 kernels, at least not without safeguarding that the
> guessed PCI region isn't occupied.

Yes, it might not be a candidate for kernel.org, but for the local
kernel tree to allow XF4 on the PowerBooks. However, Anis driver works
so far. But if you do a cold boot on the iBook as example some KDE
windows are screwed up, like the "could not open mixer" after a login.
If you boot in MacOs once and reboot into Linux it works again, looks
like an setup problem. I have that on all ati based machines here,
iBook, a beige G3 and the Wallstreet. I boot with miboot most of the
time.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
