Date: Wed, 12 May 1999 19:00:31 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Ben Martz <benmartz@earthlink.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc tree with uusbd
In-Reply-To: <v04003a02b35f877a286f@[38.27.133.131]>
Message-ID: <Pine.LNX.4.05.9905121859210.651-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 May 1999, Ben Martz wrote:

> Does anyone maintain a linuxppc tree that includes the uusbd package? I
> would like to get 2.2.7+ up and running on my iMac but obviously the old
> 2.2.0 uusbd patches can't be applied to the vger tree anymore (as an
> exercise in futility I tried!). CVS or ftp would be just fine.

UUSBD is dead (more or less, no more dev).  Getting the usb driver in
drivers/usb working properly would be much more productive.
http://soap.suitenine.com/usb/ has the current OHCI (OpenHost Controller
Interface, iirc) driver, which is what we need to have working.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
