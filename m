To: "ARIBAUD Albert" <A.ARIBAUD@giat-industries.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot 8260 LXT971A 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 30 Jun 2003 10:46:57 +0200."
             <30C145E544071F4FB8B627789F7910BD32BE35@csy-exchange1.giat.intra>
Date: Mon, 30 Jun 2003 11:00:20 +0200
Message-Id: <20030630090025.487CDC592A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <30C145E544071F4FB8B627789F7910BD32BE35@csy-exchange1.giat.intra> you wrote:
>
> My problem had something to do with MII state change interrupts not being detected properly, so the Ethernet driver was not told when the line went up after autonegociation, and thus never sent any packet.

Assuming your hardware is OK this means you  have  misconfigured  the
Linux kernel (wrong MII interrupt?)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Certainly there are things in life that money  can't  buy,  but  it's
very funny - Did you ever try buying them without money? - Ogden Nash

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
