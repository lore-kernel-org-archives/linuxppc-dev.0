To: "sruel@oerlikon.ca" <sruel@oerlikon.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: eth1 FEC on RPX-CLLF info 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Nov 2001 12:52:50 EST."
             <3BFBE9F2.2090800@oerlikon.ca>
Date: Wed, 21 Nov 2001 18:59:57 +0100
Message-Id: <20011121180002.AF8371138D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Sebastien,

in message <3BFBE9F2.2090800@oerlikon.ca> you wrote:
>
> >What happens when you enable the MDIO option?
>
> It says:
> ...
> fec: No PHY device found.

Well, this seems to be a hint...

> Yes, the LXT971 code is enabled in fec.c.
> I find out that the older CLLF_BW board was using a QS6612 PHY, but the
> CLLF_BW31 (my board revision) is using an LXT971.

Check if your hardware requires to enable and/or reset the PHY  using
some port pins or bits in a board control register...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A fail-safe circuit will destroy others.                 -- Klipstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
