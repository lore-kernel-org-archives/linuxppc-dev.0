Message-ID: <393C23CC.3289DD1F@mvista.com>
Date: Mon, 05 Jun 2000 15:03:56 -0700
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@wavemark.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Running from ROM
References: <200006052137.RAA29282@rome.wavemark.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We (MontaVista Software) are working on that.  I'm not sure schedules or
status of the project.

The idea is to have the ROM at 0x000000000 and run the kernel out of
ROM, and then have the writable structures of the kernel is some RAM
space.

My understanding is that this is for a PPC 8xx application.

--Mark Hatle
MontaVista Software, Inc.

Kent Borg wrote:
>
> I am doing some early investigation of the suitability of embedded
> Linux.  I am wondering about program loading.
>
> Traditionally, embedded systems run their programming directly out of
> ROM.  Linux doesn't seem to have any concept of such a thing.  But if
> I have a large embedded application that needs every bit of its RAM
> and ROM, I would like to find a way to get Linux to run directly out
> of ROM with no moving parts (no disks).  Anyone doing that?
>
> Thanks,
>
> -kb, the Kent who has done some web searching and is close to
> concluding no one is doing this, but he hopes he is wrong.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
