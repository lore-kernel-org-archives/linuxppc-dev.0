Date: Fri, 19 Nov 1999 22:17:00 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Eric Dorland <dorland@lords.com>
cc: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Floppy problems
In-Reply-To: <19991120005342.A515@HSE-MTL-ppp4368.qc.sympatico.ca>
Message-ID: <Pine.LNX.3.96.991119221517.13279D-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 20 Nov 1999, Eric Dorland wrote:

> I've tried a bunch of different floppies (at least 5), all give the exactly
> same error. The drive works flawlessly in the MacOS. I don't really have
> MkLinux installed to test it. Something I forgot to mention. When I try to
> to do dd, it gives the error and hangs the terminal. I can switch to another
> virt. console, but the dd process refuses to die. Is there something odd
> about the G3 floppy drive? Does anyone have this problem?

It does sound like a driver bug.  And no, the G3 machines should be using
the same (Mitsubishi or Panasonic) mechanisms used in all the other
PowerMacs.  It's remotely possible they used the Sony mechanism, but I
don't think they've done that since the Quadras, so....


> BTW, is there any utility in the MacOS to write raw disk images? DiskCopy
> will mount them, but doesn't seem to want to write them to a floppy. (Its a
> Debian i386 bootdisk).

DiskCopy should be able to write them, too.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
