From: Subodh Nijsure <subodh@best.com>
Message-Id: <200103161525.HAA26938@shell9.ba.best.com>
Subject: Re: flash writing with Linux
In-Reply-To: <3AB1E380.7E88EC47@esd-electronics.com> from Matthias Fuchs at "Mar 16, 1 10:57:20 am"
To: matthias.fuchs@esd-electronics.com (Matthias Fuchs)
Date: Fri, 16 Mar 2001 07:25:38 -0800 (PST)
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Hi,
>
> does anybody know if a flash writing tool for Linux is available ?
> I want to update a flash image from a running Linux. The Linux is
> running from a ramdisk, so the flash can be erased and rewritten.
>
> I think what I need are two thing: A device driver for accessing the
> flash and a command line tool for erasing and writing to the flash.

Perhaps you can take a look at mtd and use that to manage your flash.
With mtd you can partition your flash to different devices and erase them
selectively.

Once you have your flash partitioned you can simply cat a file to /dev/mtd#
to copy new content to the flash.

/Subodh Nijsure

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
