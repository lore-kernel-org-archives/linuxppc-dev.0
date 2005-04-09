Return-Path: <glppd-linuxppc-dev-3@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 920D667A2E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 18:09:17 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DK9nj-0002Eb-PE
	for linuxppc-dev@ozlabs.org; Sat, 09 Apr 2005 08:50:39 +0200
Received: from krepost.taket.org ([82.233.235.217])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sat, 09 Apr 2005 08:50:39 +0200
Received: from salvetti by krepost.taket.org with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sat, 09 Apr 2005 08:50:39 +0200
To: linuxppc-dev@ozlabs.org
From: Djoume SALVETTI <salvetti@crans.org>
Date: Sat, 9 Apr 2005 08:50:55 +0200
Message-ID: <20050409065055.GB23120@krepost.taket.org>
References: <1113006674.9568.414.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: news <news@sea.gmane.org>
Cc: debian-powerpc@lists.debian.org
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le samedi 04/09/05 Benjamin Herrenschmidt <benh@kernel.crashing.org> a écrit :
> echo `cat /proc/device-tree/model`

PowerBook6,4

> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done

return nothing.

-- 
Djoumé SALVETTI
