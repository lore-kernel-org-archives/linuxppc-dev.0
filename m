Message-Id: <200005312131.XAA21692@denx.local.net>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: EST SBC8260 & abatron 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 31 May 2000 16:25:43 EDT."
             <7283DE19D141D111AD0E00A0C95B195502581D61@mail2.aiinet.com>
Date: Wed, 31 May 2000 23:31:27 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <7283DE19D141D111AD0E00A0C95B195502581D61@mail2.aiinet.com> you wrote:
>
> I'm having trouble accessing the upper 8MB of the 16MB SDRAM SIMM on this
> board.
> I'm wondering if I don't have something configured wrong in my BDI2000
> config file.

Although I don't have a 8260 here to test, you could send me your BDI2000
config file.

BTW - which firmware version are  you  running?  Abatron  implemented
some Linux-friendly extensions lately...

> Would anyone care to send me one they're using that works?

Is a MPC8xx file of any uise to you?

> Also, we're trying to load the linux kernel into this system.
> How are the folks out there doing that?  Via ftp?  Via a bootloader on the
> 2MB FLASH
> chip on the board tied to /CS0?  What exactly?

Well, why don't you use your BDI2000 to load the image, or to load it
and burn it to FLASH? You already have a BDI, so use it...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The Gates in my computer are AND, OR and NOT; they are not Bill.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
