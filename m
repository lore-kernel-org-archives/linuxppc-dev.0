To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc 8250 problem with 2.4.19 kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 06 Mar 2003 10:00:30 +0100."
             <3E670E2E.7010306@dgt-lab.com.pl>
Date: Thu, 06 Mar 2003 10:36:37 +0100
Message-Id: <20030306093642.D493AC6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E670E2E.7010306@dgt-lab.com.pl> you wrote:
>
> I have some problems running 2.4.19 kernel with mpc 8250, the same
> kernel works with 8260 fine. PPCBoot works fine, but kernel chrashes wit
> random NIP at startup.

Are you 100% sure your SDRAM is working  fine?  Burst  mode  accesses
look OK on the logic analyzer?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Felson's Law:
	To steal ideas from one person is plagiarism; to steal from
	many is research.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
