To: Dale Harris <rodmur@maybe.org>
Cc: "'Mailing List: linuxppc-dev'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A question on kernel clock: 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Dec 2003 13:07:13 PST."
             <20031230210713.GC5005@maybe.org>
Date: Tue, 30 Dec 2003 22:40:32 +0100
Message-Id: <20031230214037.77A1CC12DD@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20031230210713.GC5005@maybe.org> you wrote:
>
> > > (1) which timer is used for nsleep?
> >
> > I have not the slightest idea. I don't know of any  standard  funtion
> > with that name - neither in user space nor in kernel code.
>
> Perhaps he means nanosleep().

Perhaps. But then the definition of nanosleep()  says  that  it  will
cause  a  delay  of  "at least the time specified in *req", i. e. the
upper bound is not even specified. But the  OP  seemed  to  assume  a
strict timing, so maybe it was yet another function.

Best regards, and a Happy New Year!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Old programmers never die, they just become managers.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
