Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0A2FDDD1B
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 01:58:15 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 390DE1E6E5D
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 12:57:44 -0300 (BRT)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id NyzUrgPsGAva for <linuxppc-dev@ozlabs.org>;
	Sun, 26 Apr 2009 12:57:30 -0300 (BRT)
Received: from chagas.nectar.ath.cx (unknown [187.22.248.170])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id 88E0A1E6D20
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 12:57:25 -0300 (BRT)
Date: Sun, 26 Apr 2009 12:57:09 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [2.6.30-rc3] powerpc: compilation error of mace module
Message-ID: <20090426155708.GA23159@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi there, people.

I am attempting to compile a new kernel for my OldWorld ppc box and I'm
having some problems. The first one that appears to happen is the following:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  CC [M]  drivers/net/mace.o
drivers/net/mace.c: In function ‘mace_probe’:
drivers/net/mace.c:210: error: ‘struct net_device’ has no member named ‘open’
drivers/net/mace.c:211: error: ‘struct net_device’ has no member named ‘stop’
drivers/net/mace.c:212: error: ‘struct net_device’ has no member named ‘hard_start_xmit’
drivers/net/mace.c:213: error: ‘struct net_device’ has no member named ‘set_multicast_list’
drivers/net/mace.c:214: error: ‘struct net_device’ has no member named ‘set_mac_address’
make[3]: *** [drivers/net/mace.o] Error 1
make[2]: *** [drivers/net] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/local/media/cross-compile/linux'
make: *** [debian/stamp/build/kernel] Error 2
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Any help is appreciated.


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
