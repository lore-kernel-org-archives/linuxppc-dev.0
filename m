Date: Mon, 22 Mar 1999 22:27:51 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Cort Dougan <cort@ppc.kernel.org>
Cc: Michael Meissner <meissner@cygnus.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: new bootloader
Message-ID: <19990322222751.A24222@tiktok.cygnus.com>
References: <19990316205531.A8459@tiktok.cygnus.com> <Pine.LNX.3.96.990317010455.25975A-100000@persephone.cs.nmt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990317010455.25975A-100000@persephone.cs.nmt.edu>; from Cort Dougan on Wed, Mar 17, 1999 at 01:05:03AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 17, 1999 at 01:05:03AM -0700, Cort Dougan wrote:
> Try the latest.  The OF and booting problem should be fixed.

I tried 2.2.4-pre6.  It still has the problem that there is no way to setup the
command line before booting like Gary's fixes had support for (and it ignores
the command line that I setup with OF on the PowerStack-II).  It does recognize
128meg of memory, and it does reboot cleanly.  I haven't tried it yet on the
original PowerStack with PPC1BUG (but that machine doesn't have a disk
anymore, and I stripped some of its memory for my router).

-- 
Michael Meissner, Cygnus Solutions
PO Box 98, Ayer Massachusetts, USA 01432-0098
meissner@cygnus.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
