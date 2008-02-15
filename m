Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 62A34DDF6B
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 02:39:00 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 52C84F4919F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 16:38:56 +0100 (CET)
Subject: Re: [PATCH 6/9] fs_enet: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200802151350.20627.laurentp@cse-semaphore.com>
References: <20070920220121.GF28784@loki.buserror.net>
	<200802151350.20627.laurentp@cse-semaphore.com>
Date: Fri, 15 Feb 2008 16:38:56 +0100
Message-Id: <1203089936.20350.7.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Am Freitag, den 15.02.2008, 13:50 +0100 schrieb Laurent Pinchart:

> We're loosing the possibility of having MDC and MDIO on different ports. This 
> is quite easy to fix for the non-CONFIG_PPC_CPM_NEW_BINDING case but I'm not 
> familiar with OF bindings (yet) to fix the CONFIG_PPC_CPM_NEW_BINDING case.
> 
for OF issue i had this for a paar month:
http://www.spinics.net/lists/netdev/msg45778.html
http://www.spinics.net/lists/netdev/msg47159.html
i'll be glad if it helps...

Regards
Sergej.
