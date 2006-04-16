Return-Path: <kernel@andred.net>
Received: from andred.net (sushi.andred.net [217.160.180.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E864367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Apr 2006 11:41:36 +1000 (EST)
Message-ID: <4441A0C8.8090708@andred.net>
Date: Sun, 16 Apr 2006 03:41:28 +0200
From: Andre Draszik <kernel@andred.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: IIC troubles w/ ppc4xx (STB04)
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am having trouble using iic_smbus_quick() of i2c/busses/i2c-ibm-iic.c
I am trying to i2c_probe() to probe for some devices, which at the end
calls iic_smbus_quick().

Basically, I get a Data Machine Check as soon as iic->directcntl is
accessed. Actually, this register is not described in the (old)
documentation I have.
Is anybody using this successfully on STB04?


Greets,
Andre'
