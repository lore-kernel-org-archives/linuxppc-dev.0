Date: Sun, 24 Sep 2000 00:25:17 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: R Shapiro <reshapiro@mediaone.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <14797.11370.609130.657303@ipa.ne.mediaone.net>
Message-ID: <Pine.LNX.4.10.10009240021310.17347-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > 	/* hack */
>  > 	pScrn->videoRam = 2048;
>  > [...]
>  > The hack to unconditionally set pScrn->videoRam to 2M should be removed,
>
>
> The rsync of atimach64ppc.c I got earlier today doesn't have this
> unconditonal assignment hack anymore.  The hardwired vram setting

It was too obvious to go undetected for long :-). Now if the kernel
framebuffer driver (atyfb, and don't check the 'no video driver' option
when using BootX) reportds the correct vram size the X server should see
the correct size as well.

If you have trouble with the predefined modes, just use the ones returned
by fbset -x.

I'll rsync again to see what else may have changed.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
