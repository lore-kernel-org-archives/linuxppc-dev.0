Subject: Re: RomDisk
From: Gary Thomas <gary@mlbassoc.com>
To: sunilpa@india.tek.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <001a01c254c7$b27c2260$8c679ec0@india.tek.com>
References: <001a01c254c7$b27c2260$8c679ec0@india.tek.com>
Content-Type: text/plain
Date: 06 Sep 2002 17:51:16 -0600
Message-Id: <1031356277.6302.404.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2002-09-05 at 04:33, Sunil P Antony wrote:
>
> Hello All,
> 	I'm using the romfs on my Intel strata flash which will contain the kernel
> and the application. According to the docs the romfs image is built into the
> kernel, I'd like to know if the romfs is also RAM resident all the time or
> is there a pointer that might access it from the rom device. The rom disk
> driver provided, accesses the FS data through a char array. Incase the romfs
> is always RAM resident, i would like to flash the FS image and acccess it
> from the flash. Is this possible with the current char array? Or should i
> convert it to a binary and then flash the image.
> The following link has the details....
> http://romfs.sourceforge.net/
> 	I am also interested in mounting this root ROMFS onto my flash device. But
> it gives me an "unable to open device" error. The bootargs have been
> specified as "root=/dev/flash0 ro console=tty0 console=ttyS0,9600". I'm
> using a PPC 860 architecture with Linux 2.4.
> Hoping someone could help me out in this matter.
>

Just a thought: have you considered using JFFS2 instead of the
simple ROM filesystem?  It's much more flexible and you'll find
all of the things you are asking for "just work."

--
------------------------------------------------------------
Gary Thomas               |
MLB Associates            |  Consulting for the
+1 (970) 229-1963         |    Embedded world
gary@mlbassoc.com         |
http://www.mlbassoc.com/  |
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
