To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 30 Oct 2002 17:28:51 +0100."
             <ACFC1B4A-EC24-11D6-8213-0003931C2BFA@control.lth.se>
Date: Wed, 30 Oct 2002 17:47:59 +0100
Message-Id: <20021030164804.CC8A410154@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <ACFC1B4A-EC24-11D6-8213-0003931C2BFA@control.lth.se> you wrote:
>
>    RAMDISK: Compressed image found at block 0
>    Freeing initrd memory: 361k freed
>    Kernel panic: VFS: Unable to mount root fs on 01:00
>
> Anything very obvious that is wrong?

Are you sure you have support for initial ramdisk (CONFIG_BLK_DEV_RAM
+ CONFIG_BLK_DEV_INITRD) aneabled in your kernel  configuration?  And
support for the filesystem type used in your ramdisk image?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing is easier than to denounce  the  evildoer;  nothing  is  more
difficult than to understand him.                 - Fyodor Dostoevski

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
