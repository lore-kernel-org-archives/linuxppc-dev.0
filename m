Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-Id: <s0b1dd32.069@EMAIL>
Date: Mon, 24 May 2004 11:31:55 +0530
From: "Sanjeev R" <sanjeevr@myw.ltindia.com>
To: <wd@denx.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SPI Driver for ppc8xx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I dont have the permission to acess ELDK's CVS from my network. Is there any other alternative to get the source.

Thanks
Sanjeev R

>>> Wolfgang Denk <wd@denx.de> 05/20/04 09:10AM >>>

In message <s0ad0aac.011@EMAIL> you wrote:
>
> Is the driver for SPI in mpc8xx availbale online. If yes where can i
> get it. I read that the kernel needs to be patched with the microcode

We have a SPI driver for the 8xx in the linux-2.4 module on  our  CVS
server.

> before using the SPI drivers if available.And the option is also

The  need  for  the  uCode  patch  depends  on  your  use  of   other
peripheresls, i. e. if ther eis an overlap in the parameter RAM.

> availbale in the menuconfig. What happens when it is patched?

The parameter RAM gets shifted to avoild the overlaps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Clothes make the man. Naked people have little  or  no  influence  on
society.                                                 - Mark Twain


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
