To: Pantelis Antoniou <panto@intracom.gr>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: random ramblings on 8xx patches (long and tedious :-) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Jul 2004 17:42:54 +0300."
             <410123EE.4000602@intracom.gr>
Date: Fri, 23 Jul 2004 19:22:05 +0200
Message-Id: <20040723172210.5B396C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <410123EE.4000602@intracom.gr> you wrote:
>
> IMHO we shouldn't even bother.

oops???

> Then everything should be automatically set up at run-time, based
> on probing code which should detect the rest.

You must be joking. This is for embedded systems, and code  size  and
especially boot time are critical.

Also, this suggestion does not coder Robert's intention of preventint
the user from selecting bogus configuration options for  stuff  which
doesn't exist on his chip.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Life sucks, but it's better than the alternative."
- Peter da Silva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
