To: "Oliver Fuchs" <olivers.lists@gmx.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does ext2 based on MTD acceptable for Embedded Development? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 27 Aug 2004 12:05:44 +0200."
             <412F2398.313.E2BE91@localhost>
Date: Fri, 27 Aug 2004 16:24:47 +0200
Message-Id: <20040827142452.2658DC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <412F2398.313.E2BE91@localhost> you wrote:
>
> > We do, and it works perfect. You just want to make sure to  mount  it
> > read-only.
> Is there an advantage to use ext2 instead of cramfs for read only fs?

Boot time, as you don't need to uncompress the stuff.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Windows95 = graphical user interface for a single-threaded  interrupt
handler (DOS)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
