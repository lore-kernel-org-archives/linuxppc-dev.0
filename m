To: Freddy Lugo <wilflugo@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Uncompress Ok, but cannot run linux kernel... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 May 2001 06:50:03 PDT."
             <20010508135003.34130.qmail@web9906.mail.yahoo.com>
Date: Tue, 08 May 2001 17:21:52 +0200
Message-Id: <20010508152157.613E32814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010508135003.34130.qmail@web9906.mail.yahoo.com> you wrote:
>
> I am dealing with same problem.  After the rfi (on
> turn_on_mmu) instruction an signal is generated and
> the progam counter is lost.  When performing an rfi
...
> the exception is executed.  gdb only said it recevies
> a SIGSTOP signal.  I will be working with that today.

What exectly are you trying to do?

Single-stepping over an RFI instruction? I  don't  think  you'll  get
this working.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Gods don't like people not doing much work. People  who  aren't  busy
all the time might start to _think_.  - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
