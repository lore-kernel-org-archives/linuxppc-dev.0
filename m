Message-ID: <36779490.83F6B7F4@stest.ch>
Date: Wed, 16 Dec 1998 12:08:00 +0100
From: Christoph Nadig <Christoph.Nadig@stest.ch>
MIME-Version: 1.0
To: Jeff Rugen <jrugen@primenet.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ioremap and related
References: <Pine.BSI.3.96.981214065216.24602A-100000@usr04.primenet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Jeff,

> Finally, in Xbh, they do the following code with PCI stuff -- but I don't
> really know what they're doing and was wondering if someone could explain it
> in a sentence or two and indicate a good reference to look at to understand
> it better (online if possible).  An equivalent that you would use in kernel
> code would be cool too, but I don't expect that.  ;-)

This code configures the PCI interface of the chip.It basically make the whole
video memory available
directly (in contrast to the "normal" VGA way, where only
a selectable 64K window can be accessed) and sets the
physical address to 0xC0000000.
Unfortunately the manual is no longer available online, as
this chip was phased quite a while ago.

I can fax you the respective pages of my manual,
if you like (send your number to christoph.nadig@stest.ch)

Cheers,
Christoph

--
Christoph Nadig                | mailto:christoph.nadig@stest.ch
Switching Test Solutions AG    | web   :http://www.stest.com
a Wandel & Goltermann Company  | Phone : +41 1 454-6726
Friesenbergstr. 75             | FAX   : +41 1 454-6605
CH-8055 Zurich                 |




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
