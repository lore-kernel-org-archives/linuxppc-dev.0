Date: Thu, 31 Aug 2000 15:35:24 -0700 (PDT)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: johnathan spectre <jspectre@lords.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: which kernel...?
In-Reply-To: <B5D45095.8AC7%jspectre@lords.com>
Message-ID: <Pine.GSO.4.21.0008311518010.9104-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000, johnathan spectre wrote:

> i rsync'ed down pmac-benh because someone on linuxppc-user told me that was
> what i needed to support audio on my pismo. it works great (thanks ben) as
> far as i can tell.. but there are also 4 other kernels (not to mention
> xfree86 which i haven't tried yet...) to be had.
>
> can someone explain the differences between them to me? will any of the
> others run on my pismo? is any of the others "better" or "worse" (no offense
> to all the coders involved)? should i just be quiet and happy with ben's
> latest and do all of them plan on merging at some point and then folding
> their code into what's available at www.kernel.org?

Ben H's rsync tree and precompiled kernels contain very recent work on new
PowerMac hardware support (AirPort, Pismo audio, Rage 128 video). If you
have a recent Apple machine (iBook or later), Ben's kernels may give you
hardware support that's not yet in the other development trees.

Once they are tested, Ben's changes are regularly merged into Paul's tree,
which is the main development tree for the PowerMac platform. If you don't
need the very latest changes from Ben's kernels, then Paul's rsync tree is
a good place to go.

Cort's Bitkeeper repository is a development tree for the PowerPC platform
(not just Macs and Mac clones). Patches are regularly shared back and
forth between the bk and rsync trees. They are also merged with the
mainstream (kernel.org) sources, but with less regularity.

For your hardware (Pismo), I'd recommend sticking with the rsync kernels.
Use the benh trees if you want to use (and test) the latest experimental
features, or Paul's tree if you'd rather wait for those changes to be
tested and merged.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
