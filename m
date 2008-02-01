Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B8CADDEFC
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 06:43:39 +1100 (EST)
Message-ID: <47A37653.3070305@freescale.com>
Date: Fri, 01 Feb 2008 13:43:15 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: External Interrupt
References: <47A2D424.3090903@coritel.it>	<47A32C9C.3090709@ru.mvista.com>	<47A3379F.2090004@coritel.it>	<47A33C59.4020509@ru.mvista.com>
	<47A3473D.6040505@coritel.it>
In-Reply-To: <47A3473D.6040505@coritel.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc Embedded Mailing List <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marco Stornelli wrote:
> Yes you are right. The local bus is like i2c, but I've never seen a
> device connected with i2c and described with a sub-node of i2c node in
> the dts file,

Grep the dts directory for "rtc@68".

-Scott
