Date: Thu, 25 Jan 2001 12:29:18 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Ani Joshi <ajoshi@shell.unixbox.com>, <debian-powerpc@lists.debian.org>,
        <linuxppc-dev@lists.linuxppc.org>, <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] Matrox and XFree86 4.0.2 update
In-Reply-To: <1383CA701391@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0101251138590.17251-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 24 Jan 2001, Petr Vandrovec wrote:

>
> On 24 Jan 01 at 11:11, Ani Joshi wrote:
>
> > I recently ran into an issue with the matroxfb driver and XFree86 4.0.2's
> > matrox driver.  Sometime in the past someone decided to use BE
> > register access in matroxfb for BE machines, while this is probably The
> > Right Way, it produces problems in X.  I can use BE register access
> > macro's in X but it was causing problems with the engine, perhaps some DMA
> > issue although the dma BE bits are on.
>
> Using big-endian on PPC was required by PPC users for compatibility with
> existing XF[86][68]_FBDev servers. Are you sure that there are no problems
> otherwise, and that it works correctly on all PReP/CHRP/???? architectures?

Nope it won't cause any problems, none of the XF[86][68]_FBDev servers where
accelerated for matrox, other libs (SDL etc) that have accel for matroxfb
don't work correctly for ppc either.

Changing the endian to little is the *right* thing, big-endian mode doesn't
offer us anything beyond problems in matroxfb 8/16 bit accesses become a
nightmare there...

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
