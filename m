Message-Id: <199910132113.XAA31067@denx.local.net>
To: Grant Erickson <grant@lcse.umn.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for IBM CPU's ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 13 Oct 1999 09:59:30 CDT."
             <Pine.SGI.4.10.9910130949280.12784-100000@brule.lcse.umn.edu>
Date: Wed, 13 Oct 1999 23:13:47 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.SGI.4.10.9910130949280.12784-100000@brule.lcse.umn.edu> you write:
> 
> > I have a question regarding the IBM 403GCX, is this CPU supported by
...
> At present, no. However, with ever so halting and slow progress (not due
> to difficulty, just general lack of time and resources), I'm trying to add
> in support for the 403GCX.
...
> 3) The virtual memory and cache interface is entirely different, meaning
>    that NONE of the 6xx, 7xx, or 8xx work can be leveraged here.

But Linux has already been ported to the 403; it's  even  running  in
commercial  products  like  TiVo  on  a  403.  How much difference is
between the 403xx models?


Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
...the increased productivity fostered by a friendly environment  and
quality  tools  is  essential  to  meet  ever  increasing demands for
software.               - M. D. McIlroy, E. N. Pinson and B. A. Tague

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
