To: Mark Hatle <fray@mvista.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Failsafe bootloader 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jun 2003 14:47:56 CDT."
             <3EDCFB6C.4040102@mvista.com>
Date: Tue, 03 Jun 2003 22:07:47 +0200
Message-Id: <20030603200752.DD451C5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EDCFB6C.4040102@mvista.com> you wrote:
>
> But all in all this will require you to make changes to an existing bootloader
> or write your own.

This is not correct. U-Boot can  perform  all  these  things  without
modification.  It  can  be  easily  adjusted even to more complicated
requirements - if necessary, write a shell script :-)


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perl already has an IDE.  It's called Unix.
                      -- Tom Christiansen in 375bd509@cs.colorado.edu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
