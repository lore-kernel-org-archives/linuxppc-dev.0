To: bhupinder sahran <bhup_sah@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: High resolution timer in driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Apr 2004 09:41:04 PDT."
             <20040426164104.21828.qmail@web41503.mail.yahoo.com>
Date: Mon, 26 Apr 2004 20:06:49 +0200
Message-Id: <20040426180654.5C035C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040426164104.21828.qmail@web41503.mail.yahoo.com> you wrote:
>
> I am writting a device driver. I have a requirement
> that i need a timer base interrupt serive routine
> which shall be called 1024 times in a second. But my

Find an unused timer on your processor, install an interrupt  handler
for it, and finally programm it in periodic mode with f=1024 Hz.

Where is the problem?

> understanding is saying that i can call it only once
> in a second through generic linux timer.

This is definitely wrong. Wrong twice, at least.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
They say a little knowledge is a dangerous thing,  but it is not  one
half so bad as a lot of ignorance.   - Terry Pratchett, _Equal Rites_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
