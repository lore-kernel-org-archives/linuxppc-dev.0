To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: access memory mapped registers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Jan 2003 14:00:13 PST."
             <885489B3B89FB6449F93E525DF78777F06453B@srvnt506.ALLOPTIC.COM>
Date: Fri, 10 Jan 2003 00:14:06 +0100
Message-Id: <20030109231411.AE68EC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <885489B3B89FB6449F93E525DF78777F06453B@srvnt506.ALLOPTIC.COM> you wrote:
>
> I will like to access some memory mapped registers through user space
> applications.
> Do i just use the "mmap" function calls to map the physical memory to my
> user space?

You don't. Design a proper device driver interface instead.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
By the way, ALL software projects are done by iterative  prototyping.
Some companies call their prototypes "releases", that's all.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
