MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Watchdog timer reset 
Date: Thu, 12 Aug 2004 07:14:46 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB089EE0@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: wd@denx.de [mailto:wd@denx.de]
> Sent: Thursday, August 12, 2004 8:52 AM
> To: Eli Brin
> Cc: VanBaren, Gerald (AGRE); 'linuxppc-embedded@lists.linuxppc.org'
> Subject: Re: Watchdog timer reset
>
>
> In message
> <023EF71CB65AA949A2C510353690C86B027FB4@rokonet-e.rokonet.co.i
> l> you wrote:
> >
> > But, strangely, if I don't do any printk() and printf() no resets.
> >
> > Can the printing to console from kernel/user "block" the
> kernel for so long?
>
> Yes, printk() can block the kernel for a long  time.  Try  increasing
> the  console  baudrate,  and  or not using output to a serial port at
> all.
>
> > Where is the MMU support?
>
> What do you mean?
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> It is dangerous to be right on a subject  on  which  the  established
> authorities are wrong.                                    -- Voltaire


You could also hack some code into the serial driver to kick the WDT every character or every n characters.  Ugly, but would probably get the job done for you.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
