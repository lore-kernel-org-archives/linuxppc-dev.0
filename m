Date: Sun, 6 Dec 1998 20:01:43 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: VALETTE Eric <valette@crf.canon.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Why only relocating the first three PCI base address???
In-Reply-To: <Pine.LNX.3.96.981204092651.5415A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.981206200056.17076P-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 4 Dec 1998, Cort Dougan wrote:

> 
> I only do the first 3 since that's all that was necessary in the ncr
> scsi controller on some boards.  I haven't run across anything else that
> needed relocating.  Do you know of anything that does?  It might be better
> to move all 6 but unless there was a reason to I wasn't going to bother.

No but the code  is very dangerous since you might create address
conflicts quite easily.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
