To: Jeff Stevens <jsteve17@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux MPC8xx I2C Interface 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Feb 2004 06:46:48 PST."
             <20040203144648.95218.qmail@web41404.mail.yahoo.com>
Date: Tue, 03 Feb 2004 23:46:44 +0100
Message-Id: <20040203224649.00494C10A3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040203144648.95218.qmail@web41404.mail.yahoo.com> you wrote:
>
> I am working on a proprietary board which I have
> U-Boot and ELDK Linux ported over to.  On the board
> there is an I2C bus that first connects to a PCA9556
> (I2C Hub Controller at 0x18) & PCA9516 (I2C Octal
> Hub).  So I need to be able to talk to the PCA9556 to
> set up the hub controller to activate one of the bus
> segments on the hub.  I am able to read and write to
> all my I2C devices under U-Boot, but not under Linux.
> I have tried both compiling, and creating modules of
> i2c-core, i2c-dev, and i2c-algo-8xx.  I also patched
> the kernel with the i2c patch which also gave me
> i2c-proc.  I don't get any errors when I boot with
> them compiled into the kernel, or when I insert them
> as modules.  However, I don't see any devices.  What
> am I doing wrong?  Also, I would rather talk to the

Which kernel tree is this? Did you by any chance  tried  the  sources
from our CVS server?

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A conservative is a man with two perfectly good legs  who  has  never
learned to walk.                              - Franklin D. Roosevelt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
