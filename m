Message-ID: <XFMail.990201161825.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <19990201105850.A1612@wogglebug.cygnus.com>
Date: Mon, 01 Feb 1999 16:18:25 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Michael Meissner <meissner@cygnus.com>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Cc: Cort Dougan <cort@persephone.cs.nmt.edu>, Dan Malek <dmalek@jlc.net>,
        linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 01-Feb-99 Michael Meissner wrote:
> On Wed, Jan 20, 1999 at 03:21:36PM -0000, Gary Thomas wrote:
>> I have put up all my patches against 2.2.0p7 at:
>>   ftp://ftp.linuxppc.org/gary/diffs-2.2.0p7-Jan20
>> These are diffs against the virgin 2.2.0-pre7.
> 
> Over the weekend, I moved the PowerPC to my home, and confirmed Gary's patches
> do allow me to boot on my Utah machine.  Note, the patch for
> drives/char/pc_keyb.c won't apply to 2.2.1, but its a simple matter to adjust
> the patch.
> 

I'll re-post these for 2.2.1 later [possibly today], along with a
couple of others I have.


------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
