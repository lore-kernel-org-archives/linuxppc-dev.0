To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging IBM405GP with abatron bdi 2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Aug 2003 14:37:44 EDT."
             <D73A25AA6E54D511AD74009027B1110F3C099A@ORION>
Date: Tue, 05 Aug 2003 21:12:43 +0200
Message-Id: <20030805191248.1D9E0C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <D73A25AA6E54D511AD74009027B1110F3C099A@ORION> you wrote:
>
> This tells me that the abatron is doing some type of initialization other
> than the config file.  Whatever it is doing behind the scenes is causing a
> problem after the rfi instruction.

You cannot single step through some instructions, including rfi. This
has been discussed before, you may want to search  the  mailing  list
archive.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
                                           - Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
