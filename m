To: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 Mar 2003 09:18:55 +0100."
             <se6c5894.038@mail.frequentis.com>
Date: Mon, 10 Mar 2003 09:45:21 +0100
Message-Id: <20030310084526.99000C58BB@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <se6c5894.038@mail.frequentis.com> you wrote:
>
> So the (your) DENX Kernel (2.4.4) has PCMCIA support implemented yet?

Yes.

> So this is maybe a reason for us to switch over.. (Uhuhu I hope this
> will not too much work to adapt the configuration again.... :-)

I don't think so. It's just the  usual  files  where  board-dependend
configs have to be added.

> So do you have a list which Ethernet cards work? Or is it only the Xircom card that works?

We also tested with a 3com card, but I don't remember the exact  type
(sorry,  I  don't  have  this  card  any  more). In general my PCMCIA
experience is that all cards that work in a "normal" (x86) PC  worked
fine  on  the  8xx,  too.  Ideally  you  test  before  buying using a
PowerBook...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Too many people are ready to carry the stool when the piano needs  to
be moved.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
