To: Carlo Parravicini <c.parravicini@sehitaly.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK 3.0 C++ Problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 May 2004 16:02:44 +0200."
             <200405201602.44480.c.parravicini@sehitaly.com>
Date: Thu, 20 May 2004 18:14:16 +0200
Message-Id: <20040520161421.C7222C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200405201602.44480.c.parravicini@sehitaly.com> you wrote:
>
> > What makes you think so? I bet a case of beer that the 'new" returned
> > just fine, and that your program segfaulted in memset() instead.
>
> Lost the beer, the code is wrong but the segfaulted is in the "new"
> (checked with a printf before the memset & also with gdb eh eh)

No. The new returns just fine in my test. The segfault happens in the
memset() call when you write to memory that you don't own.  I  tested
it.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The Buddha, the Godhead, resides quite as comfortably in the circuits
of a digital computer or the gears of a cycle transmission as he does
at the top of a mountain or in the petals of a flower.
            - R.  Pirsig, "Zen and the Art of Motorcycle Maintenance"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
