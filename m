To: Jon Masters <jonathan@jonmasters.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405 floating point emulation 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Nov 2003 14:38:04 GMT."
             <3FC4BACC.6000606@jonmasters.org>
Date: Wed, 26 Nov 2003 15:48:41 +0100
Message-Id: <20031126144846.791C1C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FC4BACC.6000606@jonmasters.org> you wrote:
>
> Can someone tell me what they think the status of the mathemu on ppc405
> currently is? I am faced with a situation in which we will probably
> require some kind of library or kernel emulation support and all around
> people suggest not to even go there :-).

Library support (i. e. using "-msoftfloat") works fine.

Kernel emulation is available, but makes little sense to use as it is
awfully slow.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: kernel trap (ignored)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
