Date: Fri, 7 Jul 2000 10:17:25 +1200
From: Gwyn Judd <b.judd@xtra.co.nz>
To: DeRobertis <derobert@erols.com>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fixing dead Xservcfers (was Re: seemingly random lock-up with kernel 2.2.17p7)
Message-ID: <20000707101725.A2168@thislove.dyndns.org>
References: <Pine.SGI.4.21.0007050845550.10655-100000@rainbow.uchicago.edu>; <20000706013650.A2546@thislove.dyndns.org> <Pine.SGI.4.21.0007050845550.10655-100000@rainbow.uchicago.edu> <20000706020342.B986@thislove.dyndns.org> <l03130300b58a3be9712a@[209.122.247.91]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <l03130300b58a3be9712a@[209.122.247.91]>; from derobert@erols.com on Thu, Jul 06, 2000 at 09:41:36AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 06, 2000 at 09:41:36AM -0400, DeRobertis wrote:
> At 2:03 AM +1200 on 7/6/00, Gwyn Judd wrote:
>
> >This all sounds quite familiar. The lockups have happened with both xmms
> >and mpg123. I have no idea if it is a full system lock or just X since I
> >have no remote machine to ping it with, all I am able to do is force
> >reboot.
>
> All you need to do is have your scripts which start as reset the keyboard
> mode to XLATE after the server terminates. A few lines of C code will do
> this; I think there is even a binary to do it, too.
>
> No idea why Linuxppc does not put this in the X start script.

This is not the only problem that can occur. I installed the Xpmac
server the other day and the most annoying thing it did was if it
couldn't start up correctly for some reason (one of them was that I
didn't have the 100dpi fonts installed) then it would immediately quit.
This would cue init (or gdm I'm not sure which) to try to start it
again. and again. This happened about 3 times a second rendering the
system completely unusable. I was not able to change VC's or anything
like that. Fortunately using someone else's suggestion I was able to use
the "Magic Sysrq" key combo to at least reboot the system safely.

--
Gwyn Judd (b.judd@xtra.co.nz)
A sine curve goes off to infinity, or at least to the end of the blackboard.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
