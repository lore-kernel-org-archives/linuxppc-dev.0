Return-Path: <david.jander@protonic.nl>
Received: from Mancubus.xs4all.nl (mancubus.xs4all.nl [213.84.146.227])
	by ozlabs.org (Postfix) with ESMTP id D1D1767A70
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 05:05:37 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 19 Jan 2005 19:47:16 +0100
References: <20050119164938.72597.qmail@web53803.mail.yahoo.com>
In-Reply-To: <20050119164938.72597.qmail@web53803.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501191947.16167.david.jander@protonic.nl>
Subject: Re: FW: cpm_spi.c under kernel 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 19 January 2005 17:49, annamaya wrote:
> That reminds me that I need to make the spi driver
> available somewhere all the time. But I am not sure
> when I will be able to do that. Meanwhile, you should
> be able to start of with the old driver for the 8xx
> that should be around somewhere under the rubble. :-)
> Or, you can start off with the sample code in u-boot
> that was derived from the original driver.

I just wanted to add, that if anyone is going to get busy again with the 8xx 
SPI driver(s) in u-boot and linux-2.4, I'd like to know, since I am too.
In u-boot there are two 8xx-SPI-drivers, one software and one in hardware, and 
they seem both broken now (I'm still using CVS versions around 1.1.2 
somewhere maybe I should cvs update :-)
Specifically spi_xmit() get each other in the way. There are two such 
functions in u-boot, both non-static and with (very) different prototypes, so 
I am starting to figure out the best way of fixing that mess. Is anyone busy 
with the same task?

Greetings,

-- 
David Jander
Protonic Holland.
