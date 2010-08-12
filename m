Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 4CF61B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 18:13:45 +1000 (EST)
Received: from localhost (mailhub1-int [192.168.12.234])
	by localhost (Postfix) with ESMTP id 12C3E1C832F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 10:13:42 +0200 (CEST)
Received: from mailhub1.si.c-s.fr ([192.168.12.234])
	by localhost (mailhub1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ciiwijUXVSHN for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 10:13:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id F228B1C832E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 10:13:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E0886C7393
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 10:13:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new,
	port 10023)
	with ESMTP id MJ4c2rDA4P-p for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 10:13:41 +0200 (CEST)
Received: from [192.168.4.167] (unknown [192.168.4.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A07B3C7391
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 10:13:41 +0200 (CEST)
Message-ID: <4C63AD33.7050407@c-s.fr>
Date: Thu, 12 Aug 2010 10:13:39 +0200
From: LEROY Christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Looking for a tutorial on the use of the new of_??? init functions
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

Is there a tutorial or an HOWTO out somewhere explaining the use of 
those new of_platform_xxx() and other of_xxx() functions in the init of 
drivers ? It looks like a very nice way to write drivers in Linux 2-6 
but a little help would be welcomed.

Regards
Christophe
