To: Eli Brin <eli.brin@rokonet.co.il>
Cc: "'VanBaren, Gerald (AGRE)'" <Gerald.VanBaren@smiths-aerospace.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Watchdog timer reset 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Aug 2004 14:35:08 +0200."
             <023EF71CB65AA949A2C510353690C86B027FB4@rokonet-e.rokonet.co.il>
Date: Thu, 12 Aug 2004 14:52:16 +0200
Message-Id: <20040812125221.482DDC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <023EF71CB65AA949A2C510353690C86B027FB4@rokonet-e.rokonet.co.il> you wrote:
>
> But, strangely, if I don't do any printk() and printf() no resets.
>
> Can the printing to console from kernel/user "block" the kernel for so long?

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
