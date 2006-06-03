Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AA23A67B17
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Jun 2006 10:51:13 +1000 (EST)
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 8xx spi completion sometime doesn't generate an interrupt 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 03 Jun 2006 00:21:58 +0200."
	<200606030021.58892.antonio.dibacco@aruba.it>
Date: Sat, 03 Jun 2006 02:51:10 +0200
Sender: wd@denx.de
Message-Id: <20060603005110.C3B82353A57@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200606030021.58892.antonio.dibacco@aruba.it> you wrote:
>
> I lowered the SPI bus frequency, the interrupt is now always happening but I 
> have always problems.

Try reducing the CPM load. If you have a serial  console  on  a  SMC,
shut it off, etc. Then try again (usually it will be better).

> have to double check the writing procedure. But it is also worth to note that 
> changing the PM (prescaler module) and lowering the SPI clock even more the 
> writing problem is happening less frequently. 

Yeah. At a SPI clock of 0 no errors will happen. The problem is, that
this is not too much useful either ;-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Contrary to popular belief, thinking does not cause brain damage.
