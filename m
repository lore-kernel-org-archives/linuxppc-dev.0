To: "XOL" <xol@mail.ru>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd for MPC860/862 with eldk2.1.10 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 05 Jun 2003 17:18:08 +0400."
             <E19Nud6-000EGg-00.xol-mail-ru@f16.mail.ru>
Date: Thu, 05 Jun 2003 16:25:56 +0200
Message-Id: <20030605142601.3C321C5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi XOL,

in message <E19Nud6-000EGg-00.xol-mail-ru@f16.mail.ru> you wrote:
>
> I have eldk-2.1.10 and kernel 2-4-18

ELDK 2.1.10? Such a version does not exist.

...
> RAMDISK: Compressed image found at block 0
> crc errorFreeing initrd memory: 4951k freed

Seems your ramdisk image is broken.

> VFS: Mounted root (ext2 filesystem).
> Warning: unable to mount devfs, err: -2
> Freeing unused kernel memory: 52k init
> Warning: unable to open an initial console.

The reset are probably results from the first error.

> Are there any ready to use images for eldk && 2.4.18?

Sure. See /opt/eldk/ppc_???/images/

> Probaly someone has script for copying minimum files set from nfs rootfs to ramdisk.
> What is the minimum set of files I need to boot?

See the SELF package which also  comes  with  the  ELDK;  it  is  not
exactly  the  minimum (as it provides a couple of "advanced" services
like telnet and FTP etc.), but it's a starting point, and it has been
tested to work.

> I'm new in embedded linux field so excuse me for
> such newbie questions.

You are welcome.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bumper sticker: Auntie Em: Hate you, hate Kansas, taking dog. Dorothy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
