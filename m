From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Schaffner <maschaffner@gmx.ch>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <9970.1061935809@www44.gmx.net>
References: <9970.1061935809@www44.gmx.net>
Message-Id: <1061967699.612.36.camel@gaston>
Mime-Version: 1.0
Date: Wed, 27 Aug 2003 09:01:39 +0200
Subject: Re: getting linux 2.6.0-test4 to compile on an ibook2
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-08-27 at 00:10, Martin Schaffner wrote:
> Hello,
>
> Today I compiled linux 2.6.0-test4 with almost the same options as the
> currently running 2.4. except for sound support. I had to change 8 lines in the
> code to be able to do so. Below is the patch. One line change concerns ARM
> instead of PowerPC, but the change is because of an architecture-independant API
> change, so I'm including it anyway.

There are patches significantly updating 2.6 for PowerMac that are
pending in Linus incoming queue. I suggest you use the tree at

bk://ppc.bkbits.net/linuxppc-2.5

Until all this is merged upstream

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
