Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9DE0168A22
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 08:11:58 +1100 (EST)
To: "dibacco\@inwind\.it" <dibacco@inwind.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: SPI flash kernel 2.4 driver 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 31 Jan 2006 11:43:30 +0100."
	<ITYDSI$4F4F62D0FA98B587B7D4335807D29D19@libero.it>
Date: Tue, 31 Jan 2006 22:11:55 +0100
Sender: wd@denx.de
Message-Id: <20060131211155.BF9193535E8@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <ITYDSI$4F4F62D0FA98B587B7D4335807D29D19@libero.it> you wrote:
> 
> do you know if is there a "spi flash" driver included in 2.4 kernel?
> I have an AT45DB081D (8 MBit Atmel chip) on a MPC875 spi bus.

The Katix SPI framework  is  integrated  with  our  2.4  kernel;  see
drivers/spi

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What was sliced bread the greatest thing since?
