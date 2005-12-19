Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.35])
	by ozlabs.org (Postfix) with ESMTP id 7EBB4688F7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 00:06:02 +1100 (EST)
Received: from linuxdev.ECRIN-CROLLES (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id CA96325C0D4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 14:06:00 +0100 (CET)
Date: Mon, 19 Dec 2005 14:09:14 +0100
From: Nathael Pajani <nathael.pajani@cpe.fr>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20051219140914.70cb4170.nathael.pajani@cpe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Problem loading modules
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!=20

>I'm working with a ml403 board, porting Linux 2.4.devel on it. I got the OS
>running, but I cannot load modules.
>When I try "modprobe /lib/modules/<version>/kernel/net/<module.o>, I obtain
>the error messages:
>Note: /etc/modules.conf is more recent than
>/lib/modules/<version>/modules.dep
>modprobe: Can't locate module lib/modules/<version>/kernel/net/<module.o>

did you try with insmod ?

then try running depmod.

----=20
Nathael PAJANI
Ing=E9nieur CPE Lyon
nathael.pajani@cpe.fr
