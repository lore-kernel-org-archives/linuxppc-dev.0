Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id 1A205B70A6
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 06:20:15 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
	id 1OxQ8F-0006aj-UJ
	for linuxppc-dev@ozlabs.org; Sun, 19 Sep 2010 22:05:03 +0200
Received: from nat032-252-205-109.tvoe.tv ([109.205.252.32])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 22:05:03 +0200
Received: from yanok by nat032-252-205-109.tvoe.tv with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 22:05:03 +0200
To: linuxppc-dev@ozlabs.org
From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 1/2] PPC4xx: Generelizing drivers/dma/ppc4xx/adma.c
Date: Sun, 19 Sep 2010 20:00:30 +0000 (UTC)
Message-ID: <loom.20100919T215645-646@post.gmane.org>
References: <1284774145-14543-1-git-send-email-tmarri@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tirumala,

>  drivers/dma/ppc4xx/adma.c        | 4370 +++-----------------------------------
>  drivers/dma/ppc4xx/adma.h        |  116 +-
>  drivers/dma/ppc4xx/ppc4xx-adma.h | 4020 +++++++++++++++++++++++++++++++++++

You've moved tons of code to the header file. Why?

Regards, Ilya.
