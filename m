To: Bob Beck <beck@assurtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting Linux on a Custom PPC Board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "02 Mar 2004 12:58:54 +1400."
             <1078181934.4198.20.camel@budweiser>
Date: Wed, 03 Mar 2004 00:51:44 +0100
Message-Id: <20040302235149.72299C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1078181934.4198.20.camel@budweiser> you wrote:
>
> We are writing our own boot loader code for a couple of reasons.
>
> o U-Boot does not support our ethernet chip or serial chip.

And you really  think  that  developing  a  complete  new  bootloader
(including drivers for your ethernet and serial chips) is less effort
or easier that just adding these drivers to U-Boot?

C'me on!

> o VxWorks is in flash and we cannot change that in the near future.
> o The VxWorks boot loader initializes the hardware and
>   we run our custom boot loader from its shell.

U-Boot can boot VxWorks just fine.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Space is big. You just won't believe how vastly, hugely, mind-
bogglingly big it is. I mean, you may think it's a long way down the
road to the drug store, but that's just peanuts to space.
                              -- The Hitchhiker's Guide to the Galaxy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
