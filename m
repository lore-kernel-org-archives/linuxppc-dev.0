Date: Mon, 28 Aug 2000 23:01:07 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Alex Shnitman <alexsh@hectic.net>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
In-Reply-To: <20000828233543.A23949@hectic.net>
Message-ID: <Pine.HPX.4.10.10008282257080.6537-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi Alex,


> > You can't start an ELF image from jumping at it sload address. But I know
> > only PPCBUG and OF, not your firmware.
>
> But zsrec (the thing that creates the srecords from the binary file)
> strips the 64k ELF header of the kernel image, so it should be fine?
> Or shouldn't it? Or did I misunderstand you?

Maybe. Ok, then what type of PCI bridge do you have ?
(My boards all have Motorola Raven/Falcon or Hawk and I have special
bootloader for them, but it needs residual data provided by PPCBUG).

Do you know the memory and I/O map as seen from the processor ?
Is it truly ooking like standard PreP ?

	Regards,
	Gabriel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
