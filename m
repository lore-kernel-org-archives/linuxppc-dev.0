Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3EA867A01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 07:45:35 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FZEIH-0007IJ-VV
	for linuxppc-dev@ozlabs.org; Thu, 27 Apr 2006 23:45:02 +0200
Received: from p50814d44.dip.t-dialin.net ([80.129.77.68])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 23:45:01 +0200
Received: from info by p50814d44.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 23:45:01 +0200
To: linuxppc-dev@ozlabs.org
From: Heiko J Schick <info@schihei.de>
Subject: Re: [PATCH 01/16] ehca: integration in Linux kernel	build system
Date: Thu, 27 Apr 2006 23:26:59 +0200
Message-ID: <e2rcv0$920$1@sea.gmane.org>
References: <4450B384.4020601@de.ibm.com>
	<200604271307.36987.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: news <news@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2006-04-27 13:07:36 +0200, Arnd Bergmann <arnd.bergmann@de.ibm.com> said:

> It would be more practical to put this patch last instead of
> first so you don't break the build system with partial applies.

I agree. I Will change set for the next patchset.
