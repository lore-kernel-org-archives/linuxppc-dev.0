Message-ID: <38E120DF.DD47F662@mandrakesoft.com>
Date: Tue, 28 Mar 2000 16:15:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: jlquinn@us.ibm.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: readw byte sex?
References: <852568B0.00703001.00@D51MTA03.pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


jlquinn@us.ibm.com wrote:
>
> I've seen info about this go by in the past, but wasn't paying careful
> attention...
>
> I'm working on trying to get my Advansys 970UW working under PPC linux
> 2.2.x.  I'm not tackling 2.3.x because I don't think the driver itself is
> up to date with respect to the 2.3 tree, while it is OK for x86 and alpha
> 2.2.x.  I'm having (surprise, surprise) byte swapping problems, which I so
> far am tracing to the following construct and pals:
>
>  x = le16_to_cpu(readw(addr))
>
> Both of these are byteswapping, leaving me with a reversed value, which of
> course causes havoc later.  What's the correct way to do this?  I can't
> find where the exact platform-independent semantics of readw are defined.
>
> Is this a FAQ?

readw is defined as functioning on a little endian PCI bus, so it
already should byte swap for you.

--
Jeff Garzik              | Tact is the ability to tell a man
Building 1024            | he has an open mind when he has a
MandrakeSoft, Inc.       | hole in his head.  (-random fortune)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
