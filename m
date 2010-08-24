Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 694E7B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 16:26:11 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o7O6QAWh022235
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2010 16:26:10 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7O6QAAv2203652
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2010 16:26:10 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7O6QAhp028059
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2010 16:26:10 +1000
Subject: 52xx build error
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 16:26:08 +1000
Message-ID: <1282631168.22370.517.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I get that with my current stuff:

cc1: warnings being treated as errors
In file included from /home/benh/linux-powerpc-test/arch/powerpc/platforms/52xx/mpc52xx_common.c:19:
/home/benh/linux-powerpc-test/include/linux/of_gpio.h:74: error: ‘struct gpio_chip’ declared inside parameter list
/home/benh/linux-powerpc-test/include/linux/of_gpio.h:74: error: its scope is only this definition or declaration, which is probably not what you want
/home/benh/linux-powerpc-test/include/linux/of_gpio.h:75: error: ‘struct gpio_chip’ declared inside parameter list
  CC      mm/bootmem.o
make[3]: *** [arch/powerpc/platforms/52xx/mpc52xx_common.o] Error 1
make[3]: *** Waiting for unfinished jobs....

Cheers,
Ben.
