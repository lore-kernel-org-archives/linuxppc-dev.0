Date: Mon, 22 Apr 2002 17:22:12 +0200
From: Olaf Hering <olh@suse.de>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ATI 7000 and dual-monitor X? (was Re: 9600 maturity?)
Message-ID: <20020422172212.A7257@suse.de>
References: <20020416100152.A4692@suse.de> <Pine.BSF.4.44.0204162227560.49666-100000@shell.unixbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.BSF.4.44.0204162227560.49666-100000@shell.unixbox.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 16, Ani Joshi wrote:

>
>
> On Tue, 16 Apr 2002, Olaf Hering wrote:
>
> > It is a VE, but I have one report where it fails on a 9600, after
> > loading vgahw.a or something like that. Maybe it must go into another
> > slot or the guy has to boot without video=ofonly.
> > More details later..
>
>
> This is most likely the perennial multiple PCI bus ISA IO problem in
> userland that plagues many Macs.  I won't go into the discussion again of
> why this is a problem, as this has been discussed here many times (see old
> posts about this problem on G4's), but a quick solution may be to put the
> card in the 1st slot, or whichever slot corresponds to the io_base
> syscall.  I have never used a 9600 so ask around which slot this is.
>
> Also, have you tried radeonfb?

That was the culprit. He had to boot with video=ofonly. I will try to
get some info why it fails.
Maybe another slot or a newer kernel, or both.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
