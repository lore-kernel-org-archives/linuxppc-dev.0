Date: Thu, 4 Feb 1999 15:23:44 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Gary Thomas <gdt@linuxppc.org>
Cc: Michael Meissner <meissner@cygnus.com>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        Dan Malek <dmalek@jlc.net>, Cort Dougan <cort@persephone.cs.nmt.edu>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Message-ID: <19990204152344.A2021@wogglebug.cygnus.com>
References: <19990204140930.A1710@wogglebug.cygnus.com> <XFMail.990204192134.gdt@linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.990204192134.gdt@linuxppc.org>; from Gary Thomas on Thu, Feb 04, 1999 at 07:21:34PM -0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 04, 1999 at 07:21:34PM -0000, Gary Thomas wrote:
> Before it quit, did it tell you how much memory it thought it had?
> Perhaps the OFW memory sizing stuff is wrong...  Although I thought
> I had forced it to think that there was 32M if there was no OFW.

I don't remember (and its likely to be a few days before I go in again).
The machine in question only has PPCbug installed in ROM, no OF.  It does boot
fine with an unpatched 2.2.0-pre7 floppy.

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
