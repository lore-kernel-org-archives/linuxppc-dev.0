To: cjohnson@gcctech.com
Cc: Sergey Urvanov <abs@dts.ru>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioperm 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Apr 2004 14:55:33 EDT."
             <408EACA5.8090005@gcctech.com>
Date: Tue, 27 Apr 2004 21:50:53 +0200
Message-Id: <20040427195058.E7E89C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <408EACA5.8090005@gcctech.com> you wrote:
> Normally I would agree, except that he's getting link errors with
> ioperm, inb and outb - he's not even running the code.  As to whether
> the code will work, you have an excellent point.  Maybe we're both
> right, so beers all around!

He's on a PowerPC system. Quoting "arch/ppc/kernel/syscalls.c":

int sys_ioperm(unsigned long from, unsigned long num, int on)
{
	printk(KERN_ERR "sys_ioperm()\n");
	return -EIO;
}

Guess what?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you think the problem is bad now, just wait until we've solved it.
                                                        Epstein's Law

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
