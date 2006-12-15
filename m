Return-Path: <xchen@sunrisetelecom.com.cn>
Received: from smtp01.east.net (smtp01.east.net [211.100.61.140])
	by ozlabs.org (Postfix) with ESMTP id 970E667B92
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 14:59:02 +1100 (EST)
Received: from unknown (HELO xchen)
	(Authenticated?user:?xchen@sunrisetelecom.com.cn@[211.157.209.206])
	(envelope-sender <xchen@sunrisetelecom.com.cn>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 15 Dec 2006 11:58:27 +0800
From: =?gb2312?B?s8LPow==?= <xchen@sunrisetelecom.com.cn>
To: <linuxppc-embedded@ozlabs.org>
Subject: ## Transferring control to Linux (at address 0x00000000) ... Stop here
Date: Fri, 15 Dec 2006 11:59:00 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20061215035904.970E667B92@ozlabs.org>
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

	I use uboot to start linux. And my upm table has something wrong, so
I just set the OR1 to disbale the ram burst read/write. The uboot running
looks like OK. 
	Now,when I start linux,  the terminal only displays  "##
Transferring control to Linux (at address 0x00000000) ..." and stop here. I
just want ot know if the ram mode can effect starting linux, such as
mmu,cache and so on, and I must correct upm table firstly,  or I can ignore
the point and focus on the linux kernel itself, maybe console setup, maybe
some other parameters . My goal is aeesrt the factor, ram mode, linux kernel
setup or both.

Thanks and Br,
Andy
