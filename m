Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54062DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 11:54:08 +1100 (EST)
Received: from mailhub1.br.ibm.com (unknown [9.18.232.109])
	by igw3.br.ibm.com (Postfix) with ESMTP id C8A2E390076
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Mar 2008 21:42:52 -0300 (BRST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2A0rwnH4038860
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Mar 2008 21:53:58 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2A0rwtk019188
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Mar 2008 21:53:58 -0300
Subject: Re: PPC upstream kernel ignored DABR bug
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200711290113.29024.arnd@arndb.de>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711272335.36981.arnd@arndb.de> <474DF2D8.9010407@am.sony.com>
	<200711290113.29024.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 09 Mar 2008 21:53:51 -0300
Message-Id: <1205110432.10078.5.camel@gargoyle>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roland McGrath <roland@redhat.com>,
	Jan Kratochvil <jan.kratochvil@redhat.com>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yes, I know. I tried it on the PS3 first and couldn't reproduce
> the bug he saw on the blade.

Arnd,

Do we have any news on this topic? 

I've seen this happening quite often within GDB when using hardware
watchpoints on a shared variable in a threaded (7+ threads) binary.
Sometimes the watchpoint won't trigger, even though the monitored
variable's value was modified.

Appreciate your feedback.

Best regards,

-- 
Luis Machado
LoP Toolchain
Software Engineer 
IBM Linux Technology Center
