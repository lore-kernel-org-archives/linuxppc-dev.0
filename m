To: "Sergio Massami Sakai" <Sakai@cpqd.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problems using LCD with FADS 823 & denx linux 2.4.4 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Nov 2001 14:41:08 -0200."
             <A43453F31786664ABED2E468A69079EF0F88C3@MAILSRV1.aquarius.cpqd.com.br>
Date: Wed, 21 Nov 2001 18:13:03 +0100
Message-Id: <20011121171308.96D1B1138D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A43453F31786664ABED2E468A69079EF0F88C3@MAILSRV1.aquarius.cpqd.com.br> you wrote:
>
> I´m trying to use a LCD with my FADS MPC823 board, using Linux kernel
> 2.4.4-2001-05-12 from denx, but I had some problems.

I recommend to upgrade to 2.4.4-2001-11-11.

> Using the kernel compiled with the LCD_8xx option enabled I had the
> following messages when I try to boot:
...
> Call backtrace:
> C003DBC4 C00310B0 C000245C 1000F4D0 100188C0 1000F83C 0FEE6E78
> 00000000

Can you please decode this backtrace and list the  function  names  /
offsets?

> Oops: kernel access of bad area, sig: 11
> NIP: C0027CF8 XER: C000027A LR: C0027CD0 SP: C01FFDE0 REGS: c01ffd30
> TRAP: 0300MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 3C1F1D58, DSISR: 0000012B

Which mask revision is your CPU?

> If I remove the LCD driver or turn off the LCD during the boot, the
> problem disappears.

Which display type did you configure?

> Does anyone has some idea about what is the problem and how to solve
> that?

The usual way to solve such problems is to debug the code long enough
until it's clean :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"UNIX was not designed to stop you from doing stupid things,  because
that would also stop you from doing clever things."       - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
