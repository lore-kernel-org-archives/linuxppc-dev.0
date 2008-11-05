Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 1B105DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Nov 2008 01:10:07 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: request_irq issue
Date: Wed, 5 Nov 2008 15:10:01 +0100
References: <681154.58773.qm@web46308.mail.sp1.yahoo.com>
In-Reply-To: <681154.58773.qm@web46308.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200811051510.01617.arnd@arndb.de>
Cc: Laxmikant Rashinkar <lk.atwork@yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 05 November 2008, Laxmikant Rashinkar wrote:
> But with the newer linux, request_irq() works only for 17, 18 & 19. cat /proc/interrupts shows that none of the interrupts above are in use.
> Any pointers on why request_irq() is behaving thus?

Note that you need to get the raw IRQ number from the device tree now,
and map it to a virtual IRQ number using irq_of_parse_and_map.
That is the number you pass to request_irq().

	Arnd <><
