To: "sun-zj" <sun-zj@tdk-tech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel can't boot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 Dec 2003 10:05:53 +0800."
             <200312290209.UAA07631@lists.linuxppc.org>
Date: Mon, 29 Dec 2003 09:18:11 +0100
Message-Id: <20031229081816.CE72AC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200312290209.UAA07631@lists.linuxppc.org> you wrote:
>
> Thank you for your wise instructions. I do as told . After I clear
> the clock_in_mhz environment variable the kernel boot. It goes well.
> Thanks again. :)

You are welcome.

> Our board use the Intel Flash 28F320C3T which driver for linux is not
> available now. I found that

What makes you think so? This flash chip  is  used  on  a  couple  of
boards and the existing Linux drivers work fine with it.

> I wonder if I want to develop the driver for myself, what should I do
> for the kernel?

Nothing.

Best regards, and a Happy New Year!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To be a winner, all you need to give is all you have.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
