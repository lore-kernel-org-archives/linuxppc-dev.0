Message-ID: <3680CBB0.5654@post.uni-bielefeld.de>
Date: Wed, 23 Dec 1998 11:53:36 +0100
From: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: VIA-CUDA IIC/I2C usage ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I looked a little more into the kernel-source, to find usage of
VIA-CUDA's I2C interface. For now I found it used in several
videodrivers and the dmasound driver. But all code I've seen so far does
only send to I2C, and always 2 data bytes. How do I read from the bus,
or send zero or 1 data-bytes ? Is there some "underground" documentation
for VIA-CUDA ? I'd just love to use the remote-control..

Jens

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
