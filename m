Message-Id: <200002042155.WAA07934@denx.local.net>
To: Michael Willhide <Moridin@psu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Easy question about drivers
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 04 Feb 2000 12:23:16 EST."
             <B4C07534.2AA2%Moridin@psu.edu>
Date: Fri, 04 Feb 2000 22:55:55 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <B4C07534.2AA2%Moridin@psu.edu> you write:
>
> Are video cards considered character devices?

Yes.

In simple words, a device is either a block device, or a charcter
device.

A block device is something which can hold a filesystem.

You cannot make a filesystem on a video card.

Ergo: a video card is a character device.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Of all possible committee reactions to any  given  agenda  item,  the
reaction  that will occur is the one which will liberate the greatest
amount of hot air.                                -- Thomas L. Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
