To: Prakash kanthi <pkanthi@yahoo.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Smallest Initrd (ram disk) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 12 Jan 2003 18:15:09 PST."
             <20030113021509.36487.qmail@web41214.mail.yahoo.com>
Date: Mon, 13 Jan 2003 08:55:10 +0100
Message-Id: <20030113075515.9E61AC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030113021509.36487.qmail@web41214.mail.yahoo.com> you wrote:
>
> I downloaded both the ramdisks. I would appreciate, if
> you can tell me what should i have as the value for
> "root=", in Kernel Command Line. Mine shows as
> "Linux/PPC load: console=ttyS0,19200 console=tty1
> ip=off root=/dev/part rw".

root=/dev/ram rw console=ttyS0,19200 ip=off

should be what you need.

> And also, if i select the baud rate 19200, do i have
> to change anything in the linux code other than
> initial configuration file (defconfig).

You don't have to change anything in  the  kernel.  The  baudrate  is
passed by the boot loader.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Veni, Vidi, VISA:
        I came, I saw, I did a little shopping.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
