Message-ID: <367A328E.9ED@post.uni-bielefeld.de>
Date: Fri, 18 Dec 1998 11:46:39 +0100
From: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
Reply-To: jenschrr@post.uni-bielefeld.de
MIME-Version: 1.0
To: Bryan Christianson <bryanc@ihug.co.nz>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting  a driver from x86 to LinucPPC
References: <l03130300b29d351e3bbc@[172.16.10.14]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bryan Christianson wrote:
> 
> I'm trying to port a device driver from x86 to linuxppc. I am running into
> problems with big/little endian-ness.
> 
> The device is a PCI card. Do I need to explicitly translate the data
> between big-endian and little-endian or will the io routines (outl, inl and
> inw) take care of this for me? On x86 I didn't even think about this issue,
> but now I have a feeling that maybe I should have.

I just fixed the NE2000 driver for this.

inl/outl will fix PCI's liddle-endianess to host-endianness. There is
some documentation in include/asm/io.h.

Jens


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
