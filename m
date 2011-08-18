Return-Path: <carlos.moratelli@digitel.com.br>
Received: from atena.digitel.com.br (ares.digitel.com.br [200.198.105.40])
	by ozlabs.org (Postfix) with ESMTP id 5F6E6B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Aug 2011 06:49:02 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by atena.digitel.com.br (Postfix) with ESMTP id BE61132E8023
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Aug 2011 17:47:31 -0300 (BRT)
Received: from atena.digitel.com.br ([127.0.0.1])
	by localhost (atena.digitel.com.br [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id jx6TPSGTEhVz for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Aug 2011 17:47:30 -0300 (BRT)
Received: from [192.168.20.229] (unknown [192.168.20.229])
	by atena.digitel.com.br (Postfix) with ESMTP id 535DD32E801D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Aug 2011 17:47:30 -0300 (BRT)
Subject: Question about mem parameter in the bootargs
From: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Aug 2011 17:40:42 -0300
Message-ID: <1313700042.14585.2.camel@moratelli-host.digitel.com.br>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Does someone knows what is the smallest step to increase the mem
parameter in the bootargs?

I am running linux in an embedded system where I have a very critical
memory constraint and  I would like to have mem=3584k instead mem=3M or
mem=4M.

The Linux boot up sucessfull with mem=3M or mem=4M but the kernel
crashes with mem=3584k.

thank you

Moratelli
