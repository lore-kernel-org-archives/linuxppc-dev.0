Return-Path: <andrey.warkentin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.197])
	by ozlabs.org (Postfix) with ESMTP id C40F0688A5
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2005 18:35:59 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i2so889610wra
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 23:35:58 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v746.2)
Message-Id: <61AB94A8-8912-4699-A32A-70AC1155BA34@dataarmor.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-dev@ozlabs.org
Date: Fri, 16 Dec 2005 01:35:49 -0600
From: Andrei Warkentin <andrey.warkentin@gmail.com>
Subject: Typo in arch/ppc/kernel/head.S?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello,

I was looking at head.S under arch/ppc/kernel and it seems the  
comment above ".globl __start" is slightly off. Under
the PMAC section it mentions that .text/.data/.bss are loaded @ 0x0,  
while they could be pretty much loaded anywhere but 0x0, with OF
exception vectors being there. Am I understanding this correctly?

Thanks and have a good day.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFDom5cY/rXIPQviuERAslLAJ47nV8Qo+UlzulU0VxuBdIdqEX4bQCeKB/e
ix1RS2t/M0tbqrO/3qZqDEA=
=RlQu
-----END PGP SIGNATURE-----
