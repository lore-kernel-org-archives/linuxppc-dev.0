Message-ID: <20020621193517.35031.qmail@web21110.mail.yahoo.com>
Date: Fri, 21 Jun 2002 12:35:17 -0700 (PDT)
From: Tim Lai <laitingwai@yahoo.com>
Subject: RE: Can I run Linux without a file system?
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <E1836A7F3557D311A14000805F9F36FC0141C740@usdfo011.usac.danfoss.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, Jason.
I am new to linux kernel. I'll have the main
application run from init(), so I wasn't planning
to have a file system.

> Yes. You will always have SOME kind of filesystem.
> But this begs another
> question. How much do you know about Linux, and what
> are you really asking?

If /proc and /dev is not really on any disk, what do
I have to do to init or create /dev? Do I need ramdisk
as a minumum requirement for linux?
My main goal right now is to get the serial port
to work, so I can do some debugging with the dumb
terminal. After I do tty_register() in the serial
driver, does linux assign /dev/ttyS to this device?

> The /proc filesystem is not really on any disk, just
> like /dev (I think)
> isn't on any disk, though they look like to us users
> that they are
> filesystems.
>

Can you give me pointers on which file to read?

>
> Does this help?
>

Yes. Thank you very much. :)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
