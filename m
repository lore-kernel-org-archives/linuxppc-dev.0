Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809290728i1395aa8er66069e1fcb1513e5@mail.gmail.com>
Date: Mon, 29 Sep 2008 10:28:04 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: USB support on mpc5200 broken
In-Reply-To: <874p3zowv1.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop> <48E02FD0.8000809@genesi-usa.com>
	<20080929034329.GB8694@yookeroo.seuss>
	<9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
	<874p3zowv1.fsf@macbook.be.48ers.dk>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 29, 2008 at 10:22 AM, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:
>
> Hi,
>
>  Jon> How do I adjust my build to put the DTB into a wrapper? I'm
>  Jon> based on the pcm030 makefile and it assumes the DTB is built
>  Jon> externally.
>
>  Jon> Can u-boot handle the wrapped DTB? I'm using a pointer to kernel
>  Jon> and one to DTB when booting from u-boot.
>
> See my recent (nacked by Wolfgang, but sane in principle) patch for
> uImage.<platform> support:
>
> http://patchwork.ozlabs.org/patch/589/

So I should wait for the version that uses FIT images.

>
> --
> Bye, Peter Korsgaard
>



-- 
Jon Smirl
jonsmirl@gmail.com
