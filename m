Date: Tue, 29 Aug 2000 19:43:58 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
Message-ID: <20000829194358.C29944@hectic.net>
References: <20000828233543.A23949@hectic.net> <Pine.HPX.4.10.10008282257080.6537-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10008282257080.6537-100000@gra-ux1.iram.es>; from paubert@iram.es on Mon, Aug 28, 2000 at 11:01:07PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Gabriel!

On Mon, Aug 28, 2000 at 11:01:07PM +0200, you wrote the following:

> > > You can't start an ELF image from jumping at it sload address. But I know
> > > only PPCBUG and OF, not your firmware.
> >
> > But zsrec (the thing that creates the srecords from the binary file)
> > strips the 64k ELF header of the kernel image, so it should be fine?
> > Or shouldn't it? Or did I misunderstand you?
>
> Maybe. Ok, then what type of PCI bridge do you have ?

It uses a Winbond chip for PCI/ISA bridge. (I can find the exact model
if it'd help.)

> Do you know the memory and I/O map as seen from the processor ?

Yes, it's in the brochure.. If I send it to you would it help?

> Is it truly ooking like standard PreP ?

How would I know? Frankly, I'm a newbie in this business...


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

/real/ kernel hackers
    dd if=/dev/urandom of=/vmlinuz
and influence the Universal Randomosity Field.
	-- Gaal Yahas

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
