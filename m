Date: Mon, 1 Feb 1999 10:58:50 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Gary Thomas <gdt@linuxppc.org>
Cc: Johnnie Peters <jpeters@phx.mcd.mot.com>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        Dan Malek <dmalek@jlc.net>, Cort Dougan <cort@persephone.cs.nmt.edu>,
        Michael Meissner <meissner@cygnus.com>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Message-ID: <19990201105850.A1612@wogglebug.cygnus.com>
References: <36A520DE.DCC9F600@phx.mcd.mot.com> <XFMail.990120152136.gdt@linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.990120152136.gdt@linuxppc.org>; from Gary Thomas on Wed, Jan 20, 1999 at 03:21:36PM -0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 20, 1999 at 03:21:36PM -0000, Gary Thomas wrote:
> I have put up all my patches against 2.2.0p7 at:
>   ftp://ftp.linuxppc.org/gary/diffs-2.2.0p7-Jan20
> These are diffs against the virgin 2.2.0-pre7.

Over the weekend, I moved the PowerPC to my home, and confirmed Gary's patches
do allow me to boot on my Utah machine.  Note, the patch for
drives/char/pc_keyb.c won't apply to 2.2.1, but its a simple matter to adjust
the patch.

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
