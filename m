Message-ID: <3EF2EE71.5070504@intrex.net>
Date: Fri, 20 Jun 2003 07:22:25 -0400
From: Ralph Blach <rblach@intrex.net>
MIME-Version: 1.0
To: Laurent Mohin <laurent.mohin@acterna.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: framebuffer access in little endian mode
References: <OFE7EE0F3B.3DB23516-ONC1256D4B.0023C9C9-C1256D4B.0026ED64@se.wavetek.com>
In-Reply-To: <OFE7EE0F3B.3DB23516-ONC1256D4B.0023C9C9-C1256D4B.0026ED64@se.wavetek.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laurent,

One thought would be to modify the pte entries to support little endian and have an
IO_Remap little endian.  (To those who think this is herasy or what ever, I accept you
critisisms.)

Any body else out there with better, and I know there must be better solutions?

Chip

Laurent Mohin wrote:
> Hello,
>
> I'm designing a custom board with a 405GPr and a Silicon Motion SMI712
> graphic controller. The interface to this chip is via PCI interface and it
> gives access to its internal framebuffer in little endian format. Because
> access done by the 405GPr are in big endian, color in 16bpp mode aren't
> displayed correctly.
>
> Unfortunately, it seems that the chip doesn't provide a way to access the
> framebuffer in big endian format.
>
> Any  hints are welcome.
>
> Laurent
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
