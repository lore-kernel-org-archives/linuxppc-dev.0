To: vze8n24y@verizon.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: C++ on PowerQUICC 1 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Apr 2004 17:12:38 -0000."
             <20040402171238.NAJJ5247.out014.verizon.net@outgoing.verizon.net>
Date: Fri, 02 Apr 2004 20:14:25 +0200
Message-Id: <20040402181430.0DAE3C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040402171238.NAJJ5247.out014.verizon.net@outgoing.verizon.net> you wrote:
>
> I would like to run a C++ program on a PowerQUICC  I  with  8MB  of
> Ram.  I  have  been  told  that  this may not be possible to do. Does
> anyone have experience with the memory requirements for  C++  with  a
> PQ1?

This may be possible, or not. It is impossible to say without knowing
anything about your C++ program.  A  simple  hello-world  application
will not need more than a few kilobytes (plus the C++ libraries).

However, it is trivial to create multi-megabyte sized applications, too.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Don't tell me how hard you work.  Tell me how much you get done.
                                                     -- James J. Ling

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
