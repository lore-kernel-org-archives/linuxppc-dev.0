To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jul 2003 08:18:34 PDT."
             <20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net>
Date: Fri, 11 Jul 2003 17:43:18 +0200
Message-Id: <20030711154323.4B267C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Tom,

in message <20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> > We changed this in our kernel tree some time ago. If no valid PHY  is
> > found  we simply do not enable the interface, but we do not panic any
> > more.
>
> Which raises two fun questions:
> 1) Do you plan on ever trying to re-sync your 2.4 tree with the
> community tree (which should become kernel.org before too long)?

We do this from time to time. The last  (visible)  re-sync  was  with
2.4.20  (ChangeSet  1.1174  =  20021129181904|49831), which is half a
year ago. On the other hand, we don't have the  resources  to  follow
each and every change immediately.

> 2) Do you plan on trying to keep in sync with 2.6 now that it's coming
> up on us?

Of course we will follow 2.6 as well.

Why are you asking? Did I give any reason to think we might go out of
business?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are three principal ways to lose money: wine, women,  and  en-
gineers.  While  the first two are more pleasant, the third is by far
the more certain."                      -- Baron Rothschild, ca. 1800

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
