Date: Fri, 2 Feb 2001 17:27:43 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Steven Hanley <sjh@wibble.net>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: agpgart? or how to use dri?
In-Reply-To: <19341227173347.15692@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.30.0102021705270.25118-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Feb 2001, Benjamin Herrenschmidt wrote:

>
> >
> >> I slightly hacked my own
> >> to build since I lack the glide libs necessary for the 3dfx stuff to
> >compile.
> >
> >what does glide have to do with this? isnt that only used with tdfx?
>
> Yes, but the Makefile of the kernel DRM modules will build all modules
> (3dfc, ati, ...) and so would fail when the glide headers are not there.
.....
> Well, what I did was to:
>
>  - Get Gareth CVS branch
>  - Make World
>  - remove tdfx in the drivers Makefile and the DRM kernel makefile

Until now the default for ppc was #define HasGlide3 NO if this has been
changed to YES, then disabling it in you hosts.cf should work.

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
