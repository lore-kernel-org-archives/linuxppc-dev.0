Message-ID: <023EF71CB65AA949A2C510353690C86B027FB7@rokonet-e.rokonet.co.il>
From: Eli Brin <eli.brin@rokonet.co.il>
To: "'Wolfgang Denk'" <wd@denx.de>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Watchdog timer reset 
Date: Thu, 12 Aug 2004 16:11:18 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,

>Yes, printk() can block the kernel for a long  time.  Try  increasing
>the  console  baudrate,  and  or not using output to a serial port at
>all.

My console baudrate is 115,200.

I will modify the code and use syslog, and then I will be able to redirect
the logging to the syslogd on my Linux PC.  I hope no blocking there.

Regarding the MMU, if I can replace copy_from_user with memcpy, then the
kernel address space is the same as the users, or I'm wrong?

Best regards,
Eli Brin



-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thursday, August 12, 2004 2:52 PM
To: Eli Brin
Cc: 'VanBaren, Gerald (AGRE)'; 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: Watchdog timer reset

In message <023EF71CB65AA949A2C510353690C86B027FB4@rokonet-e.rokonet.co.il>
you wrote:
>
> But, strangely, if I don't do any printk() and printf() no resets.
>
> Can the printing to console from kernel/user "block" the kernel for so
long?

Yes, printk() can block the kernel for a long  time.  Try  increasing
the  console  baudrate,  and  or not using output to a serial port at
all.

> Where is the MMU support?

What do you mean?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is dangerous to be right on a subject  on  which  the  established
authorities are wrong.                                    -- Voltaire


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
