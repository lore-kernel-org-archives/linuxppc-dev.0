To: tschaefer@giga-stream.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fw_setenv problem when calling from expect script 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Jun 2004 14:20:27 +0200."
             <FIEJJAKAABLMHFKFECNJCEHIHBAA.tschaefer@giga-stream.de>
Date: Tue, 08 Jun 2004 16:07:21 +0200
Message-Id: <20040608140726.8A969C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <FIEJJAKAABLMHFKFECNJCEHIHBAA.tschaefer@giga-stream.de> you wrote:
>
> I'm using MVL 3.0 (kernel 2.4.18) on a PPC 405GPr custom board. Flash memory
> on the board is located in 2 AMD641DH flash chips, which are concatenated on
> the mtd layer to one large flash memory area. The flash is divided into 5
> partitions (bootloader u-boot, 2 bootloader environment partitions, kernel,
> rootfs).

More interesting than the kernel  version  would  be  to  know  which
version  of the MTD subsystem you are using. A 2.4.18 kernel sounds a
bit old, so this probably means that the MTD code is even older?

...
> CRC write error on /dev/mtd1: Input/output error
> Error: can't write fw_env to flash
...
> The respective environment sector has been erased, but writing the new
> environment didn't work.
>
> If I insert a 'sync' command between writing on the rootfs partition and the
> fw_setenv call, writing of the environment sector works, but this is not
> really a solution???

No. Definitely not. Soulds like a MTD problem to me.

> Any ideas, comments?

Update the MTD code?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Lead me not into temptation... I can find it myself.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
