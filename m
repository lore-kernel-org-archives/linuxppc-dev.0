To: Mark Hatle <fray@mvista.com>
Cc: Christophe.LINDHEIMER@fr.thalesgroup.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Running Linux with 2Mo of Ram. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Jun 2003 11:16:06 CDT."
             <3EE8A746.7010901@mvista.com>
Date: Thu, 12 Jun 2003 23:53:05 +0200
Message-Id: <20030612215310.7D7E6C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EE8A746.7010901@mvista.com> you wrote:
>
> You will need some type of "execute in place", i.e. run the kernel and/or
> userspace applications out of ROM in order to work with 2MB of RAM.
>
> This type of thing is generally very board, processor and application specific.
>   So I don't believe there is existing (open source) code to do it.

It's easy to add, at least for  a  8xx  system  booting  with  U-Boot
(which supports XIP).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Brain fried - Core dumped

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
