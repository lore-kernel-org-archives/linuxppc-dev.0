Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 3D50AB7198
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 21:49:41 +1000 (EST)
Received: from localhost (mailhub1-int [192.168.12.234])
	by localhost (Postfix) with ESMTP id 04C601C81EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 13:49:38 +0200 (CEST)
Received: from mailhub1.si.c-s.fr ([192.168.12.234])
	by localhost (mailhub1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KG0Mxc++XExm for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 13:49:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id E3CF71C81BF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 13:49:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D6B58C73DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 13:49:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new,
	port 10023)
	with ESMTP id f2Z1PmVm91t5 for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 13:49:37 +0200 (CEST)
Received: from [192.168.4.167] (unknown [192.168.4.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 965BDC73DD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 13:49:37 +0200 (CEST)
Message-ID: <4C80E0CB.9050507@c-s.fr>
Date: Fri, 03 Sep 2010 13:49:31 +0200
From: LEROY Christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Dual ethernet attachment with single FEC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  Hello,

I have a board with 2 PHYs attached to one FEC.
I want to implement some kind of main-standby attachment to LAN by 
setting the ISOLATE bit on one on the two PHYs then monitoring the link 
status and switch to the other PHY when the link status goes down.

What would be the most proper way to implement this functionality ?
* Modify FEC driver to manage that ?
* Implement a virtual PHY driver that would manage that ?
* Other solution ?

Best regards
C. Leroy
