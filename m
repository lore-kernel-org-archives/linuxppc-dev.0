Subject: Re: Booting Linux on a Custom PPC Board
From: Bob Beck <beck@assurtech.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040302235149.72299C0655@atlas.denx.de>
References: <20040302235149.72299C0655@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1078249516.4228.7.camel@budweiser>
Mime-Version: 1.0
Date: 03 Mar 2004 07:45:16 +1400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-03-03 at 13:51, Wolfgang Denk wrote:
> In message <1078181934.4198.20.camel@budweiser> you wrote:
> >
> > We are writing our own boot loader code for a couple of reasons.
> >
> > o U-Boot does not support our ethernet chip or serial chip.
>
> And you really  think  that  developing  a  complete  new  bootloader
> (including drivers for your ethernet and serial chips) is less effort
> or easier that just adding these drivers to U-Boot?
>
> C'me on!

Actually, we know we need to develop drivers for our ethernet and
serial chips for Linux. We are not convinced yet that developing
these drivers for U-Boot too is useful given the fact that VxWorks
is already booted up.
>
> > o VxWorks is in flash and we cannot change that in the near future.
> > o The VxWorks boot loader initializes the hardware and
> >   we run our custom boot loader from its shell.
>
> U-Boot can boot VxWorks just fine.
>
What I mean is that the VxWorks boot loader is already booting
up an really old version of VxWorks. We aren't using VxWorks for
this project for various reasons. It just happens to be part of
the legacy development environment.


Bob

>
> Best regards,
>
> Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
