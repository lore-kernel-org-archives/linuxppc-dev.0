Message-ID: <408FD605.2010302@gcctech.com>
Date: Wed, 28 Apr 2004 12:04:21 -0400
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Sergey Urvanov <abs@dts.ru>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioperm
References: <20040427195058.E7E89C109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I stand humbled before the master.  Not that I ever doubted, really.
 Please forward information regarding your favorite local bar or liquor
store, along with your beer preference.

Is there a concept of having "I/O permissions" for user mode programs on
ppc?  If so, how do they acquire such permission?

Wolfgang Denk wrote:

>In message <408EACA5.8090005@gcctech.com> you wrote:
>
>>Normally I would agree, except that he's getting link errors with
>>ioperm, inb and outb - he's not even running the code.  As to whether
>>the code will work, you have an excellent point.  Maybe we're both
>>right, so beers all around!
>>
>
>He's on a PowerPC system. Quoting "arch/ppc/kernel/syscalls.c":
>
>int sys_ioperm(unsigned long from, unsigned long num, int on)
>{
>	printk(KERN_ERR "sys_ioperm()\n");
>	return -EIO;
>}
>
>Guess what?
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>If you think the problem is bad now, just wait until we've solved it.
>                                                        Epstein's Law
>
>

--
Christopher R. Johnson
Principal Software Engineer
GCC Printers
(781)276-8763


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
