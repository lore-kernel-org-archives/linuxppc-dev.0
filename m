To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST sbc8260 boot debug 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Nov 2003 08:51:50 EST."
             <3FB0E976.20500@catapult.com>
Date: Tue, 11 Nov 2003 15:04:34 +0100
Message-Id: <20031111140439.5C13AC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FB0E976.20500@catapult.com> you wrote:
>
...
> into some problems.  This is a 8275 FADS board.

Arrrrggghhhh!!! Why do you write "EST sbc8260" in the subject, then?


> I have downloaded the simple-ramdisk-PPCBoot supplied

This ancient ramdisk image is NOT suitable to a MPC82xx processor.  I
have  removed  it  from our FTP server some time ago, and I recommend
everybody to rm it, too.

Please use a SELF image from the
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/ directory
instead.

> I tftpboot the kernel to 100000, the simple-ramdisk to 300000
> set boot args to root=/dev/ram rw   then    bootm 100000 300000
> and still run into problems:

It would have been extremely useful if you had actually shown HOW you
do this, and the relevanlt lines for the kernel boot log. Instead you
just send a useless snippet.

> Here is the last part of the start up log
>
> ...

...which is more or less useless without the first part  which  shows
which boot arguments you actually passed to the kernel.

> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: devfs_debug: 0x0
> devfs: boot_options: 0x1

Try disabling devfs in your kernel configuration.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"One day," said a dull voice from down below, "I'm going to  be  back
in  form again and you're going to be very sorry you said that. For a
very long time. I might even go so far as to make even more Time just
for you to be sorry in."              - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
