Date: Thu, 22 Jul 2004 09:20:40 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440GX: mapping PCI address
Message-ID: <20040722092040.B17187@home.com>
References: <45ABD2373C33C4459D42B40EC4F346F2024CA461@FTWMLVEM03.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45ABD2373C33C4459D42B40EC4F346F2024CA461@FTWMLVEM03.e2k.ad.ge.com>; from Renaud.Barbier@ge.com on Thu, Jul 22, 2004 at 09:43:26AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 22, 2004 at 09:43:26AM -0500, Barbier, Renaud (GE Infrastructure) wrote:
> Indeed, I get a virtual address out of mmap
> but my system freezes when I access it.
> I try to access the PCI external configuration registers:
>
> ptr=(unsigned int *)mmap(0, getpagesize(), PROT_READ | PROT_WRITE,
>                              MAP_SHARED, fd, 0x0ec00000);
>
>
> My kernel is 2.4.21 I would guess it should work from what I have seen regarding
> messages about 36-bit address on 440GX.

Check the archives, I've posted a URL for the 36-bit mmap patch
several times.

-Matt (one who reads archives and googles to get FAQs answered :P)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
