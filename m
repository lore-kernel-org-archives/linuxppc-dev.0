Return-Path: <j.revathy@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 99425DDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Dec 2006 16:16:48 +1100 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id BD0A187813D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Dec 2006 20:45:12 -0800 (PST)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r6cj204512-00-2
	for linuxppc-embedded@ozlabs.org; Tue, 19 Dec 2006 20:45:12 -0800
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 8E6A687813B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Dec 2006 20:45:12 -0800 (PST)
Message-ID: <4588BFDF.8090608@gdatech.co.in>
Date: Wed, 20 Dec 2006 10:15:19 +0530
From: revathy <j.revathy@gdatech.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Ethernet hangs
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

Hi all,
          Iam working on linux-2.6.18 on MPC8540 board, iam using Marvel 
and Intel's phys, the ethernet test is not passed under linux,when i 
enable gianfar etherent the board hangs after "RAMDISK driver 
initialized: 16 RAM disks of 16384K size 1024 blocksize".Can  anyone  
suggest  how to proceed.
Thanks in advance.
