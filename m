Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 8C84267A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 10:08:58 +1100 (EST)
To: "veikko romppainen" <blind_miksu@hotmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 16 Mar 2005 23:22:25 +0200."
	<BAY12-F147D953D7254016B942F2994480@phx.gbl>
Date: Thu, 17 Mar 2005 00:08:42 +0100
Sender: wd@denx.de
Message-Id: <20050316230847.8D0B1C1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: porting linux & u-boot on Mdp Pro 8xx board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <BAY12-F147D953D7254016B942F2994480@phx.gbl> you wrote:
> 
> I have currently running wxWorks on Mdp Pro 823 board. Now i'm trying port 
> Linux on it. Firstable i have to get u-boot working on it. I hope someone 
> has done this.

Probably not. At least I don't know of any port of  U-boot  for  this
board.

BUT: this is off topic here. Please post U-Boot related questions  on
the U-Boot mailing list instead.

> Is there working configuration from u-boot to this board?
> I have modified QS823 conf, because it looks quite similar.

Similar is not good enough.

> Can I use VisionIce 2 and SingleStep to flash u-boot?

Probably, if you know how to use these tools. Sorry, I'm afraid  there
is little help for these on tyhe U-Boot list.

> We dont't have BDI in our school, shame. I flashed u-boot by using Ice 
> starting at 0xfff00000. It seemed that it went correct place but nothing 
> happened when i started my board.

Is this the correct address for your board? Did you use  the  correct
terminal baudrate?

> I suppose that I can't  debug it with Ice and SingleStep.

You should be able to. If not, return the tools to the vendor and get
your money back.

> Do i have to flash more than just u-boot.bin in right address? 

No.

> (Environment?)

No. If  the  environment  is  invalid  (bad  CRC  checksum),  then  a
compiled-in default environment will be used.

> Do i need  some reg files or prj files?

Dunno.

> I would appreciate if someone could help me with these addresses and 
> configs.
> 
> Board specs:
> MPC 823 66 Mhz
> 4Mb flash
> 128 Mb RAM
> 512 K SRAM
> 8 K eeprom

Sorry, you need a lot more information about the hardware to give any
usable help - and then it requires a non-negligible amount of work to
come up with the right config data. Don't  expect  too  much  from  a
mailing list.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Don't tell me how hard you work.  Tell me how much you get done.
- James J. Ling
