To: Arun Dharankar <ADharankar@ATTBI.Com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial console ports on systems with no console connected. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Jul 2002 21:27:16 EDT."
             <200207082127.16518.ADharankar@ATTBI.Com>
Date: Tue, 09 Jul 2002 07:14:05 +0200
Message-Id: <20020709051410.43CC11086F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200207082127.16518.ADharankar@ATTBI.Com> you wrote:
>
> This question is common to both ppcboot and ppc-linux.
> The ppcboot I am using is 1.1.5 and Linux kernel 2.4.18.
>
> If there is no console connected to the serial console port,
> is it true that a thread sending output to it hangs? If this is

No, this is NOT true.

Why should it? There is no flow control used - neither in the PPCBoot
nor in the Linux UART drivers...

> I have a MPC8260ADS based board, and see the above

...at least not in the standard MPC8xx and MPC8260 UART drivers.

> behavior under ppcboot. Under Linux using a BDI debugger
> the thread sending output to the console hangs. Perhaps

You must be doing something wrong.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you believe that feeling bad or worrying long enough will change a
past or future event, then you are residing on another planet with  a
different reality system.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
