Date: Mon, 4 Oct 1999 07:57:36 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: hollis@andrew.cmu.edu
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Voodoo3 support
In-Reply-To: <37F84F94.3A4FE3D0@andrew.cmu.edu>
Message-ID: <Pine.LNX.4.10.9910040752150.32347-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>





> 
> (Posted to wrong list.)
> Anyone have a Voodoo 3?
> 
> -Hollis


	Jeff Garzik has already started a voodoofb driver and i have a
copy of it at home.  Its a basically a skeleton driver with the pci
probing for voodoo etc...  anyhow, i was gonna start the actual driver
last weekend but i'm still not done with rivafb :(   anyhow, once i think
i can get some initial mode states pretty easily since there's  a ton of
docs/drivers for this.  If anyone has already "claimed" voodoofb on ppc
lemme know, otherwise i'll put up some patches soon.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
