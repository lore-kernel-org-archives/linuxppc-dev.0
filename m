To: "gguevel" <gguevel@interfaceconcept.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to receive IP and RAW frames on the same ethernet device ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Sep 2002 19:23:42 +0200."
             <000001c25825$a572e5c0$3101a8c0@DOMAIN>
Date: Mon, 09 Sep 2002 21:34:32 +0200
Message-Id: <20020909193437.B88F6FA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Gérard,

in message <000001c25825$a572e5c0$3101a8c0@DOMAIN> you wrote:
>
> I work on a custom 860 board with Linux 2.2.14.

What a day is this? Seems everybody using this old  stuff  is  active
today ;-)

> I want to receive and send IP and RAW frames simultaneously on the same
> ethernet device.

Use a raw socket; something like

	socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));

should be all that's needed; get yourself a copy  of  libnet,  and/or
libpcap.


However, I have no idea if this ever worked in 2.2.14; you might want
to use a more recent kernel version.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as we know, our computer has never had an undetected error.
		                                           -- Weisert

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
