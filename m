Date: Sun, 28 Nov 1999 15:49:13 -0600
From: Shaw Terwilliger <sterwill@io.nu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.30-pre3
Message-ID: <19991128154913.A15762@io.nu>
References: <Pine.LNX.4.05.9911282232240.361-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.9911282232240.361-100000@callisto.of.borg>; from geert@linux-m68k.org on Sun, Nov 28, 1999 at 10:35:03PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> This does not mean 2.3.30-pre3 is running on my box, I'm just compiling...
> Paul's unstable rsync tree (linux-pmac-devel) doesn't compile, so I wanted to
> give Linus' tree a try

I'm running Paul's unstable tree now, but it took a bit of hacking to make it
compile.  fs/hfs is still using the 2.2 VFS calls, so I just stole fs/hfs
from Linus's tree, stuck it in, and it works.  The Mac keyboard driver
was also all busted (quite a few half-written / missing functions), so I
just wrote them like I thought they should go, and I'm typing through the
keyboard right now.  

I think I might have also had to tweak some other part of the code (I'm
thinking atyfb, but I can't remember).

I can make diffs if anyone wants them; I'm sure some other people would
rather like to build from Paul's unstable tree.  :)  I'd been using
his stable tree, but for the last 3 months, I can't boot one of his
stable kernels without getting a machine check somewhere in init.
The unstable ones have no problems with it, although my USB mouse seems
to have stopped working... (so now I'm trying to make Xpmac use some
keys to emulate mouse buttons, but they seem hard-coded, so it'll be
a little harder than I thought).

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
