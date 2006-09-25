Return-Path: <j.revathy@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 6A63A67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 16:20:57 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 493658780B8
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 22:51:08 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r69o225108D-00-2
	for linuxppc-embedded@ozlabs.org; Sun, 24 Sep 2006 22:51:08 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 1F43B8780B6
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 22:51:08 -0700 (PDT)
Message-ID: <45176E60.6030406@gdatech.co.in>
Date: Mon, 25 Sep 2006 11:21:28 +0530
From: revathy <j.revathy@gdatech.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Trouble booting Kernel 2.6.12 on powerpc 8540
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
   First time iam porting linux kernel 2.6.12 on MPC8540(PIC) board.In
platform code  i have set the CCSRBAR  to 0xff70 0000 which is the
default value for 8540. it gets hanged at "Uncompressing kernel image...ok".Iam
using u-boot-1.1.2.

Should i edit anything in .config file?

Thanks and Regards
Revathy
