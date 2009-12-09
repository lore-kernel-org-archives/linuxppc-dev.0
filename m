Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D7E8B6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 17:56:55 +1100 (EST)
Subject: gianfar breaking builds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 17:56:44 +1100
Message-ID: <1260341804.16132.22.camel@pasglop>
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

In my next (not pushed out yet as I'm writing this but will be by the
time you read it hopefully), I get a build failure:

/home/benh/linux-powerpc-test/drivers/net/gianfar.c: In function ‘gfar_netpoll’:
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2653: error: invalid storage class for function ‘gfar_interrupt’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2652: warning: ISO C90 forbids mixed declarations and code
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2681: error: invalid storage class for function ‘adjust_link’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2764: error: invalid storage class for function ‘gfar_set_multi’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2855: error: invalid storage class for function ‘gfar_clear_exact_match’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2877: error: invalid storage class for function ‘gfar_set_hash_for_addr’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2898: error: invalid storage class for function ‘gfar_set_mac_for_addr’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2922: error: invalid storage class for function ‘gfar_error’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3017: warning: ‘alias’ attribute ignored
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3032: error: invalid storage class for function ‘gfar_init’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3037: error: invalid storage class for function ‘gfar_exit’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3041: error: invalid storage class for function ‘__inittest’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3041: warning: ‘alias’ attribute ignored
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042: error: invalid storage class for function ‘__exittest’
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042: warning: ISO C90 forbids mixed declarations and code
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042: warning: ‘alias’ attribute ignored
/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042: error: expected declaration or statement at end of input
make[3]: *** [drivers/net/gianfar.o] Error 1

Stephen says that breakage has been in -next for some time...

Can you guys sort it out ?

Cheers,
Ben.
