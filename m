Date: Fri, 18 Aug 2000 13:17:15 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Michel Lanners <mlan@cpu.lu>
cc: olh@suse.de, linuxppc-dev@lists.linuxppc.org, geert@linux-m68k.org
Subject: Re: some stuff about controlfb in 2.2
In-Reply-To: <200008181922.VAA03812@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10008181314420.15263-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 18 Aug 2000, Michel Lanners wrote:

> I think the better way to handle this would be to provide a
> device-specific mmap function in the framebuffers that benefit from the
> changed caching. On Macs, all unaccelerated framebuffers should fall
> under that category.

The framebuffer device API can handle this, write a controlfb_mmap() and
set the fb_mmap pointer in fb_ops to it.


ani

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
