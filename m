Date: Tue, 16 Apr 2002 22:35:09 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Olaf Hering <olh@suse.de>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ATI 7000 and dual-monitor X? (was Re: 9600 maturity?)
In-Reply-To: <20020416100152.A4692@suse.de>
Message-ID: <Pine.BSF.4.44.0204162227560.49666-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Apr 2002, Olaf Hering wrote:

> It is a VE, but I have one report where it fails on a 9600, after
> loading vgahw.a or something like that. Maybe it must go into another
> slot or the guy has to boot without video=ofonly.
> More details later..


This is most likely the perennial multiple PCI bus ISA IO problem in
userland that plagues many Macs.  I won't go into the discussion again of
why this is a problem, as this has been discussed here many times (see old
posts about this problem on G4's), but a quick solution may be to put the
card in the 1st slot, or whichever slot corresponds to the io_base
syscall.  I have never used a 9600 so ask around which slot this is.

Also, have you tried radeonfb?


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
