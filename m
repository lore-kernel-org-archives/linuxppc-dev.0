To: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 configuration 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 01 Oct 2002 20:07:39 CDT."
             <0B0A39652BB0D411BCCF00508B9512EC08AEB3FC@tx14exm05.ftw.mot.com>
Date: Wed, 02 Oct 2002 09:09:26 +0200
Message-Id: <20021002070931.AC53CFA98@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Bo,

in message <0B0A39652BB0D411BCCF00508B9512EC08AEB3FC@tx14exm05.ftw.mot.com> you wrote:
>
> I had boot code ( with vxWorks and it is based on EST8260 bsp) in my custom
> board
> already. I decide to download the linux object via tftp. But I have the
> following
> questions:
>
> 1. Do I have to configure IMMR as 0xF0000_0000 or higher. The default
> configuration
>     in our boot is 0x0F00_0000 ? Is this a hard requirement or not ? If so,

Yes, this is a hard requirement.  See  the  Embedded  PowerPC  HOWTO,
especially the part about the memory map.

> why can't linux
>     init code do so by writing to IMMR+0x101a8 ?

Linux relies on certain initialization beind done by the firmware.

> 2. How to specify the start address where linux runs when I build the zImage
> ?

The start address of the Linux kernel on PowerPC is fix - it's 0x0000.

> 3. When I make xconfig, what configuration I must have in order to run ? I
> certainly
>    do not need VGA/HARD DISK/PCI (this board does not have pci devices).

There is a default configuration that should you  get  started.  Just
type:

	$ make est8260_config
	$ make oldconfig

> 4. Is there any good website/paper/documentation about linux for 8260
> platform.

Not that I know.

You may have a look a http://www.denx.de/re/DPLG.html though. Most of
the things are not CPU specific.

> 5. Can anyone access ftp.leo.org to get ELDK ? I can ping it but I cannot
> ftp it today.

Works for me.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Status quo. Latin for "the mess we're in."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
