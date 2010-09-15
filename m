Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 6492FB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 02:02:32 +1000 (EST)
Received: from localhost (mailhub1-int [192.168.12.234])
	by localhost (Postfix) with ESMTP id 9CA421C8153
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 18:02:30 +0200 (CEST)
Received: from mailhub1.si.c-s.fr ([192.168.12.234])
	by localhost (mailhub1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ZDslAAh4RfR for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 18:02:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 8213F1C814F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 18:02:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DAB2EC73C9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 18:02:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new,
	port 10023)
	with ESMTP id 2HUJVuINtvMN for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 18:02:28 +0200 (CEST)
Received: from [172.25.231.36] (unknown [172.25.231.36])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 139C5C7393
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 18:02:27 +0200 (CEST)
Message-ID: <4C90EE12.9020608@c-s.fr>
Date: Wed, 15 Sep 2010 18:02:26 +0200
From: LEROY Christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: DSP in MPC8xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  Hi,

I accordance with document MPC8xxRMAD the CPM of MPC8xx includes some 
DSP functions.
However, it is not real clear if some additional microcode is needed or 
not to operate it.

Does anyone know any implementation of that DSP functionality with Linux ?

Regards
C. Leroy
