Date: Tue, 26 Sep 2000 21:27:02 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Olaf Hering <olh@suse.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <20000926204606.B467@suse.de>
Message-ID: <Pine.LNX.4.10.10009262125400.21452-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I've posted such a patch to debian-powerpc when one user there had this
> > problem. That was before I learned booting with yaboot avoids the problem.
> > If the resource conflict also happens on oldworld machines, I'd still
> > prefer some suggestions to foolproof the patch (as in: how can I figure
> > out if a region has been allocated by another card? What bits from the
> > config registers should I look at?).
>
> I have a precompiled benh Kernel at penguinppc.org/~olaf with Benhs current
> kerneltree, your patch is still needed - otherwise *kaboom*

No surprise there. But I don't consider the patch clean enough for
inclusion with the 2.2 kernels, at least not without safeguarding that the
guessed PCI region isn't occupied.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
