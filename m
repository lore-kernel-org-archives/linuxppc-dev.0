To: "Stephen Williams" <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Relationship between bk libuxppc-2.4 and denx linuxppc_2_4_devel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 Jun 2004 16:53:28 PDT."
             <11675-28654@sneakemail.com>
Date: Fri, 11 Jun 2004 09:30:54 +0200
Message-Id: <20040611073059.D13E8C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <11675-28654@sneakemail.com> you wrote:
>
> What is the relationship between the linuxppc-2.4 tree from
> bk, and the anonymous cvs linuxppc_2_4_devel hosted by Denx?

Our linuxppc_2_4_devel CVS tree is a (modified, extended) copy of the
BK tree of the same name, which used to be the "official" development
tree but has been declared dead a long time ago.

> The latter *seems* more stable, but I'm hoping to integrate
> in patches for me JSE board after cleaning up patches, and
> it's not clear which tree I should work with.

You should work with  the  official  trees,  i.  e.  linuxppc-2.4  or
linuxppc-2.5.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It would be illogical to assume that all conditions remain stable
	-- Spock, "The Enterprise" Incident", stardate 5027.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
