Subject: Re: MPC850SAR with SPI support
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: li <slowforce@21cn.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <GW969369996858.28984@webmail4.inner-21cn.com>
References: <GW969369996858.28984@webmail4.inner-21cn.com>
Content-Type: text/plain
Message-Id: <1056962361.2827.4879.camel@zambia.cambridgebroadband.com>
Mime-Version: 1.0
Date: 30 Jun 2003 09:39:21 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Li,

Why are you combining an SPI driver with an ATM driver?  Shouldn't you
create two separate drivers instead?

Alex

On Sun, 2003-06-29 at 17:31, li wrote:
> Hi all,
> I am implementing SPI interface with MPC850SAR and linux kernel 2.4.18.
> The following is what i have done:
> 1. set the SPI related registers
> 2. allocate the dpram and memory for SPI buffer
>    descriptor and RX/TX buffer.
> 3. enable all possible interrupts for SPI
> After writing  to SPI interface, i can get transmit interrupt from cpm, since SPI performs write and read simultaneously, the BD_SC for READ will be set with not EMPTY, but in fact it is not. And what i get in the SPI dev is not correct.
> ps: i select the I2C and SPI UCODE PATCH when making menuconfig.
> Any comment please go ahead!
> regards!
> Li
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
