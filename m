To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: "Michael R. Zucca" <mrz5149@acm.org>,
	David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: fetch_and_add() available on PPC Linux?Hi, 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 06 Dec 2001 09:07:57 EST."
             <20011206140445.TQHJ17034.tomts10-srv.bellnexxia.net@there>
Date: Thu, 06 Dec 2001 16:00:30 +0100
Message-Id: <20011206150035.6BB10F9C1@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20011206140445.TQHJ17034.tomts10-srv.bellnexxia.net@there> you wrote:
>
> I think it is the same as the cache line size (32 bytes for most ppc
> machines but defintely that cache line size changes for some
> implementations (so go with at least 32 bytes and you should be safe).

...except on embedded CPUs like MPC8xx which have a cache  line  size
of only 16 bytes

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I've finally learned what `upward compatible' means. It means we get
to keep all our old mistakes." - Dennie van Tassel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
