Date: Tue, 24 Oct 2000 16:12:07 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Olaf Hering <olh@suse.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ThinkPad 850 Patches for 2.2.16
In-Reply-To: <20001024212920.A23705@suse.de>
Message-ID: <Pine.SOL.3.96L.1001024160753.11432A-100000@unix12.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Oct 2000, Olaf Hering wrote:
>
> On Tue, Oct 24, Benjamin Herrenschmidt wrote:
>
> > I beleive you must have a way to probe for the machine type and do the
> > right thing, don't you ?
>
> We need it, but not in arch/ppc :)

Right; that auto-setup is already in prep_setup.c, and has been for a
while.

> The cs4232.c driver has already some interrupt stuff that you can adjust
> in .config. But we know the needed values so we could hardcode it in the
> driver itself.

Cort said if anyone can convince the cs4232 driver maintainer to accept
the hack, then great.

Otherwise it seems the hack will live where it is, to allow the same
binary kernel to run on Motorola and IBM PReP boxes with sound support.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
