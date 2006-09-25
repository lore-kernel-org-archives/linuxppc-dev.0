Return-Path: <j.revathy@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 74A1567A2E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 16:14:54 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 416088780C3
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 23:14:53 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r69o231453D-00-2
	for linuxppc-embedded@ozlabs.org; Sun, 24 Sep 2006 23:14:53 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id E97678780C0
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 23:14:52 -0700 (PDT)
Message-ID: <451773F4.5080306@gdatech.co.in>
Date: Mon, 25 Sep 2006 11:45:16 +0530
From: revathy <j.revathy@gdatech.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Unable to boot kernel 2.6 from u-boot 1.1.2 in MPC8540
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: revathy <j.revathy@gdatech.co.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I am currently working on a MPC8540 based custom board to port linux-2.6.x. 
 iam using  kernel-2.6.12 in which platform code  CCSRBAR   is set to 0xff70 0000 which is the
default value for 8540 found from HRM. it hangs at "Uncompressing kernel image...ok".Iam
using u-boot-1.1.2.



Should i edit anything in .config file?
or am i missing something anywhere?

 Could someone help me to solve this issue.

Thanks and Regards
Revathy
