Date: Fri, 15 Jan 1999 18:33:14 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
Cc: Michael Meissner <meissner@cygnus.com>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        gdt@cygnus.com
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Message-ID: <19990115183314.A6917@tiktok.cygnus.com>
References: <19990115165805.A28318@tiktok.cygnus.com> <Pine.LNX.3.96.990115150135.11410A-100000@persephone.cs.nmt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990115150135.11410A-100000@persephone.cs.nmt.edu>; from Cort Dougan on Fri, Jan 15, 1999 at 03:04:30PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 15, 1999 at 03:04:30PM -0700, Cort Dougan wrote:
> His gets it from the OF.  There's no OF code used in the prep bootloader
> in the current kernels.
> 
> Are you netbooting or floppy booting?
> 
> }Also, Gary Thomas's 2.0.32 kernel seemed to have no problem in sizing memory,
> }so I presume it is able to pick up the residual data.

Floppy booting, and I've also tried installing it in /dev/sda1. 

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
