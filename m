To: Dean Matsen <deanmatsen@earthlink.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Jul 2003 13:54:42 PDT."
             <3F0C8112.5060001@earthlink.net>
Date: Wed, 09 Jul 2003 23:21:40 +0200
Message-Id: <20030709212145.49E24C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F0C8112.5060001@earthlink.net> you wrote:
>
> I think the search should be made smarter (especially, keep going to
> the next address until it has gone through ALL address w/o finding a
> valid ID).  The kernel could still panic if it can't find any PHY chip,
> but not the first time it reads the floating line and can't find the
> answer in its table.  The odds of reading a valid PHY ID from the
> floating line is phenominally low.  I'd submit a proposed patch for
> this, but it doesn't sound like anyone else thinks this is important
> enough to warrant a change.

I agree that it makes little sense for th kernel to panic if it finds
an unsupported PHY id.

> the automatic PHY search will work.  Unless the pullup is required for
> non-search applications (which I assert it isn't), then I think the code
> should be fixed, not the hardware.

We changed this in our kernel tree some time ago. If no valid PHY  is
found  we simply do not enable the interface, but we do not panic any
more.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A witty saying proves nothing."                           - Voltaire

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
