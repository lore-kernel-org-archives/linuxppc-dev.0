Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id C1454B7D97
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 09:00:16 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
	id 1OOesR-0001xT-NB
	for linuxppc-dev@ozlabs.org; Wed, 16 Jun 2010 00:45:03 +0200
Received: from ppp89-110-3-77.pppoe.avangarddsl.ru ([89.110.3.77])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 00:45:03 +0200
Received: from dbaryshkov by ppp89-110-3-77.pppoe.avangarddsl.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 00:45:03 +0200
To: linuxppc-dev@ozlabs.org
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v2] lite5200: fix ethernet phy address
Date: Tue, 15 Jun 2010 22:19:51 +0000 (UTC)
Message-ID: <hv8ua6$uq0$1@dough.gmane.org>
References: <1276154181-25534-1-git-send-email-dbaryshkov__1637.54533646188$1276154215$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dmitry Eremin-Solenikov wrote:

> According to my schematics, on Lite5200 board ethernet phy uses address
> 0 (all ADDR lines are pulled down). With this change I can talk to
> onboard phy (LXT971) and correctly use autonegotiation.

What about this patch?

-- 
With best wishes
Dmitry
