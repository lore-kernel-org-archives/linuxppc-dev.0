Date: Thu, 13 Mar 2003 17:00:53 +0100
From: Olaf Hering <olh@suse.de>
To: mikpe@csd.uu.se
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
Message-ID: <20030313160053.GA8585@suse.de>
References: <15984.39762.858447.704784@gargle.gargle.HOWL> <20030313152506.GB28311@suse.de> <15984.43692.736225.647094@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15984.43692.736225.647094@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Thu, Mar 13, mikpe@csd.uu.se wrote:

> Olaf Hering writes:
>  >  On Thu, Mar 13, mikpe@csd.uu.se wrote:
>  >
>  > > vmlinux.coff built from 2.4.20-ben8 fails immediately at boot
>  > > on my old-world PowerMac 4400 (OF 2.0.2) with a CLAIM error:
>  > >
>  > > 0> boot fd:vmlinux.coff root=/dev/hda8 loading XCOFF
>  > > tsize=5E40 dsize=C500C bsize=215DC entry=500000
>  > > SECTIONS:
>  > > .text	00500000 00500000 00005E40 000000D4
>  > > .data	00506000 00506000 000C500C 00005F14
>  > > .bss	005CB000 005CB000 000215DC 00000000
>  > > loading .text, done..
>  > > loading .data, done..
>  > > clearing .bssCLAIM failed
>  >
>  > Can you provide the 'printenv' output? Does flushing the pram help?
>  > And my patch does fix the 'loading .data' error, your bug is different.
>  >
>  > Does the vmlinux.coff from http://penguinppc.org/~olaf/2.4.6/ boot?
>
> Yes! Your 2.4.6 vmlinux.coff booted from floppy without problems.

I'm not sure if the 2.4.18 version fits on a floppy, but it should still
boot.

--
A: No.
Q: Should I include quotations after my reply?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
