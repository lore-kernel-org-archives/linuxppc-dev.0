To: "Stephen Williams" <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hardware Requrements for Linux on 405GPr 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 14 Aug 2003 13:05:33 PDT."
             <21518-79162@sneakemail.com>
Date: Thu, 14 Aug 2003 22:26:33 +0200
Message-Id: <20030814202638.969A0C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steve,

in message <21518-79162@sneakemail.com> you wrote:
>
> We are in the process of designing a PCI board that will have
> a 405GPr, some SDRAM and a Compact Flash. (Not to mention
> the functionality of our device.) Outside the 405GPr itself,
> are there any minimum device requirements for a Linux that
> can for example run some simple servers?

You need some boot device (flash?); you  need  some  RAM  (>=  16  MB
recommended).

> For example, the matter of whether or not a RTC is required
> came up amongst the designers.

If you don't need a current time of day then no RTC is needed.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Ever try. Ever fail. No matter. Try again. Fail again.  Fail  better.
                                                        -- S. Beckett

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
