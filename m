Message-ID: <3F54EACB.5090904@mvista.com>
Date: Tue, 02 Sep 2003 12:08:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Andr=E9_L=E4mmer?= <alaemmer@fh-konstanz.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola LoPEC
References: <004e01c37092$ab2d8890$0f21258d@fhkonstanz.de>
In-Reply-To: <004e01c37092$ab2d8890$0f21258d@fhkonstanz.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


André Lämmer wrote:

>Hi!
>
>I have a Motorola PPC-board. It is the LoPEC-P011 with PPC5-Bug version
>1.3. The board has only a network connection an no hard disk or flash
>memory.
>
>Now, I want run Linux on it. My idea is to load the bootloader with tftp
>und mount the filesystem with nfs.
>
I think what you mean is that you want to load the zImage (compressed
kernel + arch/ppc/boot/... bootwrapper [+ initrd]) and mount the root
filesystem via nfs.

> The problem is, that I cannot find
>any working bootloader. I tried ppcboot, but there is no config for the
>LoPEC.
>
That board should have come with working firmware.  Did it get erased or
something?  If so, you should be able to get a fw binary from Morotola.

>Do anyone know a installtion guide for this board? Or is there a working
>bootloader and kernel?
>
Look on the MOT website.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
