Date: Tue, 23 Mar 1999 08:39:14 -0500
From: Michael Meissner <meissner@cygnus.com>
To: linuxppc-dev@lists.linuxppc.org
Cc: Cort Dougan <cort@ppc.kernel.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: new bootloader
Message-ID: <19990323083914.A1863@tiktok.cygnus.com>
References: <19990316205531.A8459@tiktok.cygnus.com> <Pine.LNX.3.96.990317010455.25975A-100000@persephone.cs.nmt.edu> <19990322222751.A24222@tiktok.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990322222751.A24222@tiktok.cygnus.com>; from Michael Meissner on Mon, Mar 22, 1999 at 10:27:51PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 22, 1999 at 10:27:51PM -0500, Michael Meissner wrote:
> 
> On Wed, Mar 17, 1999 at 01:05:03AM -0700, Cort Dougan wrote:
> > Try the latest.  The OF and booting problem should be fixed.
> 
> I tried 2.2.4-pre6.  It still has the problem that there is no way to setup the
> command line before booting like Gary's fixes had support for (and it ignores
> the command line that I setup with OF on the PowerStack-II).  It does recognize
> 128meg of memory, and it does reboot cleanly.  I haven't tried it yet on the
> original PowerStack with PPC1BUG (but that machine doesn't have a disk
> anymore, and I stripped some of its memory for my router).

I forgot to mention I used most of the common defaults instead of prep, adding
pc style parallel ports, pc style floppies, and removing a few mac ethernet
targets.  So except for the command line thing, it looks like a winner.

-- 
Michael Meissner, Cygnus Solutions
PO Box 98, Ayer Massachusetts, USA 01432-0098
meissner@cygnus.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
