To: Tom Rini <trini@kernel.crashing.org>
Cc: Rune Torgersen <runet@innovsys.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 CPM DP ram free function 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 May 2004 12:23:33 PDT."
             <20040521192333.GI6763@smtp.west.cox.net>
Date: Mon, 24 May 2004 15:50:36 +0200
Message-Id: <20040524135041.AB280C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040521192333.GI6763@smtp.west.cox.net> you wrote:
>
> First, when this has come up in the past, the first question is why is
> this useful, given that with the hardware and peripherals in question,
> loadable drivers aren't really useful (and don't shoot the messenger
> please).

As has been discussed before, too, loadable drivers are  very  useful
during  development;  they  can  even be useful in production systems
when you need and easy way to update software updates  in  a  running
system.

The fact that hte existing drivers don't support this is IMHO more of
an historical lapse than an argument for or against such a feature.

The fact alone that this is at least  the  third  implementation  and
this  feature which was submitted for inclusion with the public trees
should make clear that there is some need for it.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Little known fact about Middle Earth:   The Hobbits had a very sophi-
sticated computer network!   It was a Tolkien Ring...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
