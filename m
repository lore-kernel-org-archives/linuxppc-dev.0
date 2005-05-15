Return-Path: <jreiser@BitWagon.com>
Received: from jade.spiritone.com (jade.aracnet.com [216.99.193.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97038679E7
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2005 08:43:59 +1000 (EST)
Received: from [192.168.0.2] (216-99-213-225.dsl.aracnet.com [216.99.213.225])
	(authenticated bits=0)
	by jade.spiritone.com (8.12.8/8.12.8) with ESMTP id j4FMb0Op017444
	for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2005 15:37:01 -0700
Message-ID: <4287CF06.5000809@BitWagon.com>
Date: Sun, 15 May 2005 15:36:54 -0700
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 2GB limit on TASK_SIZE for user address space on 32-bit PowerPC
Apple Macintosh is getting in the way of database, filesystem
maintenance, and scientific applications.  In user mode, most
i686 desktops can address 3GB.  While 64-bit systems are becoming
available, the vast majority of existing systems are still 32-bit.
What can be done to get a larger address space for existing Macs?

According to arch/ppc/syslib/prom_init.c, the first problem is
that CONFIG_BOOTX_TEXT restricts CONFIG_TASK_SIZE to only 0x80000000.
Is this an initialization-only restriction that just happens
to persist beyond initialization?  What would it take to remove
this collision from affecting life after boot?  How much of booting
does CONFIG_BOOTX_TEXT affect?

-- 
