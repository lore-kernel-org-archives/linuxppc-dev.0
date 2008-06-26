Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00F93DDF3A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 00:11:40 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: Microblaze init port v4
Date: Thu, 26 Jun 2008 14:29:29 +0200
Message-Id: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,

current linux version is 2.6.26-rc8 and I think this is the right time
to send latest patches againts rc8 for Microblaze CPU.

I fixed there some issues which were reported to me.

We have there still problem with syscalls and we don't have chance to 
fix it to stable version, this is not part which I can do yourself. 
Microblaze will be n + 1 platform which use some old syscalls. 
I hope you understand.

I am sending more than 50 patches and I would like to see ACKs for patches
which are good and comments for patches which are bad.

Thanks for your time and review.

Best regards,
Michal Simek
www.monstr.eu
