Date: Sat, 30 Jan 1999 04:09:48 -0800 (PST)
From: Matt McLean <keys@yikes.com>
To: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
cc: mlan@cpu.lu, O.Waller@ee.qub.ac.uk, linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody?
In-Reply-To: <19990130020006.A580@toocool.calpoly.edu>
Message-ID: <Pine.BSF.4.01.9901300409020.18729-100000@brio.yikes.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 30 Jan 1999, dhiltgen@toocool.calpoly.edu wrote:

> And the one other simple question... how in the heck do you tell 
> XF68 which /dev/fb* to go to?  Right now I'm moving the devices
> around by hand, but I'd eventually like to get a Dual headed X setup
> going.

Use the $FRAMEBUFFER environment variable (that's in Documentation/fb.txt
i think) :-)

m.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
