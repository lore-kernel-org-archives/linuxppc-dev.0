Date: Thu, 2 Nov 2000 11:46:31 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Todd Inglett <tinglett@vnet.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Yet another RS6k whipped!
In-Reply-To: <3A006299.73525FEE@vnet.ibm.com>
Message-ID: <Pine.HPX.4.10.10011021136540.15431-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 1 Nov 2000, Todd Inglett wrote:

>
> Enclosed is the original boot log for Linux on a 43P-140 (200mhz).  As
> you might guess it is still a way off from being useful.  Thanks go to
> Tom Gall who did the initial work (but ran out of time) and Dave Monroe
> for being on irc when I got frustrated :).
>
> For those interested this box boots as prep but has an openpic.  It can
> run with a chrp style memory map which is probably what I am going
> attempt next after installing something on the disk.  This boot log is
> with a prep memory map.

Ok, there were a few bugs with Openpic on PreP: some functions were marked
__chrp while openpic support is a completely orthogonal issue. Yours seems
to work, however, which source tree are you using ?  (I'm still basing
everything on kernel.org).

Besides this, it's fairly close to what I do on my MVME boxes: the
firmware puts them in PreP mode and I reorganize them as CHRP. This forces
me to reorganize all the PCI space (but the code has not been with bridges
and will probably fail). You have open firmware, which is hopefully more
flexible than PPCBUG which I have to use.

I am late in publishing my patches (on ftp://vlab1.iram.es/pub/liux-2.4),
hopefully I can be back to hacking around the 15th...

	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
