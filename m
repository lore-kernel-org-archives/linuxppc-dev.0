To: Juergen Kienhoefer <juergen@kienhoefer.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cache coherence problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Nov 2003 21:00:44 PST."
             <3FB9A77C.3030101@kienhoefer.com>
Date: Tue, 18 Nov 2003 09:04:34 +0100
Message-Id: <20031118080439.7AF33C5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3FB9A77C.3030101@kienhoefer.com> you wrote:
>
> Basically, what I need to do is:
...
> for every 32 bytes of the memory block I put code in.
...

s/32/CACHE_LINE_SIZE/g

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Windows95 = graphical user interface for a single-threaded  interrupt
handler (DOS)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
