To: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CPU performance measurement 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Jul 2002 17:56:57 -0300."
             <B7AC573479F05C438F232539B961A168095007@CUR1006V.br002.siemens.net.br>
Date: Tue, 23 Jul 2002 23:14:04 +0200
Message-Id: <20020723211409.9635F10875@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear OtavioOtavio,

in message <B7AC573479F05C438F232539B961A168095007@CUR1006V.br002.siemens.net.br> you wrote:
>
> >>You did mount the /proc filesystem, didn't you?
> I though /proc filesystem was mounted but it is not. My custom board is

Ummm.. I guess you have a login or any other way to access a shell on
your board? You can (and should) manually check which filesystems are
mounted, and mount anything that may be missing.

> running a 6MB ramdisk and I receive the following message when Linux
> goes up:
>
> EXT-f2 warning: mounting unchecked fs, running e2fsck is recommended

This is harmless - just an indication that  your  way  to  build  the
ramdisk image is more or less broken.

> VFS: Mounted root (ext2 filesystem)
> Freeing unused kernel memory: 60k init 4k openfirmware
> INIT; version 2.78 booting
> Checking all file systems...
> Parallelizing fsck version 1.19(13-jul-2000)
> Mounting local filesystems...
> Not mounted anuthing

To me this seems pretty much overkill for a ramdisk  of  an  embedded
system;  have  a  look  how  we  do this in our Simple Embedded Linux
Framework, see ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/

> I tried to run e2fsck but no success. Any idea what can I do to fix fs?

Fix the the build process for your ramdisk image.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I used to be indecisive, now I'm not sure.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
