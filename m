In-Reply-To: <B0CAE42C9EE0D311AAAD00500422FC6302CD74@iis000.microdata.fr>
Date: Fri, 18 Feb 2000 14:48:57 +0100
To: Patrick Lerda <Lerda@microprocess.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: insw/outsw/insl/outsl (was: Re: your mail)
Message-Id: <20000218144857.016035@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 18, 2000, Patrick Lerda <Lerda@microprocess.com> wrote:

>In my opinion we need new functions for quick byte copy, with new names.
>The names insw/outsw/insl/outsl are to close to inw, outw, insw...;
>these functions work with the PCI bus, and data need a conversion to
>little-endian,
>before read and write operation.
>
>We need new functions and fix the kernel.

I'm not sure we need new functions at all.

Do you know a single case where swapping would actually be required with
insw/outsw/insl/outsl ?

All cases I encountered so far (IDE, sound, ethernet), those are used to
transfer stream of bytes between device and memory. In this case, the
access width is irrelevant and no swapping must be done.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
