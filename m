Message-ID: <3EE4FC3E.5010209@mvista.com>
Date: Mon, 09 Jun 2003 14:29:34 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: dong in kang <dkang@east.isi.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting Linux without bootloader on Sandpoint X3 with PPC755
 CPU, Montavista Linux
References: <000f01c32eae$819c7ed0$45a97241@Minjoo>
In-Reply-To: <000f01c32eae$819c7ed0$45a97241@Minjoo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dong-In,

This has come up and been answered several times before.  Please search
the linuxppc-embedded and linuxppc-dev mail archives.

Mark
--

dong in kang wrote:

> Hello,
>
> I try to boot MontaVista Linux on Sandpoint X3 with PPC755 CPU.
>I make zImage.initrd for Sandpoint X3, and loaded it on the SDRAM at
>0x800000.
>I used bdi to initialize memory controller and load the binary image of
>zImage.initrd on the SDRAM.
>Although I don't use bootloader, I can read/write SDRAM without any problem.
>The only change I made is memory size change in
>arch/ppc/platform/sandpoint_setup.c file
>
> size = 128*1024*1024;   /* 128 M bytes */
>
>I also changed the size of memory in the boot parameters.
>
> However, the Linux doesn't seem to boot properly.
>The serial line keeps silent.
>It keeps running. When I halt the running with bdi, it is in
>"emit_log_char".
>Could anybody tell me what's possibly wrong?
>
> Thanks,
>
> Dong-In
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
