To: Dan Malek <dan@mvista.com>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CPCI-405 port (PPC405GP) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Sep 2001 11:20:26 EDT."
             <3BAA093A.10E96272@mvista.com>
Date: Sun, 23 Sep 2001 20:01:13 +0200
Message-Id: <20010923180118.83CBB1009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BAA093A.10E96272@mvista.com> you wrote:
>
> No, the way to Linux is to _always_ use a zImage with an attached bootloader.

This is your private opinion, it seems.

I see no reason to do this. Why should I? Attaching a bootloader is
nonsense when the firmware does everything the bootloader might do,
and more and better.


Please explain why you think this is the one and only way?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I paid too much for it, but its worth it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
