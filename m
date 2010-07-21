Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id C5C7CB70C5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 06:33:32 +1000 (EST)
Received: by eyh6 with SMTP id 6so3991619eyh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 13:33:30 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] tqm85xx: enable PCMCIA bridge on ST85xx baseboards.
Date: Thu, 22 Jul 2010 00:33:22 +0400
Message-Id: <1279744404-10171-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Baseboards for tqm85xx modules (STK85xx) bear TI PCI1520 PCMCIA controllers.
These two patches enables one to fully use this controller in Linux.
