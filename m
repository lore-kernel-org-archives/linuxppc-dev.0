From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Date: Wed, 24 Jan 2001 20:44:49 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [linux-fbdev] Matrox and XFree86 4.0.2 update
CC: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Message-ID: <1383CA701391@vcnet.vc.cvut.cz>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 24 Jan 01 at 11:11, Ani Joshi wrote:

> I recently ran into an issue with the matroxfb driver and XFree86 4.0.2's
> matrox driver.  Sometime in the past someone decided to use BE
> register access in matroxfb for BE machines, while this is probably The
> Right Way, it produces problems in X.  I can use BE register access
> macro's in X but it was causing problems with the engine, perhaps some DMA
> issue although the dma BE bits are on.

Using big-endian on PPC was required by PPC users for compatibility with
existing XF[86][68]_FBDev servers. Are you sure that there are no problems
otherwise, and that it works correctly on all PReP/CHRP/???? architectures?

And I think that matroxfb should return current driver's endianess to
userspace... Do we have some spare bits in fb_fix_info?
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
