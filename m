Return-Path: <msuresh@gamebox.net>
Received: from smtp-out.hotpop.com (smtp-out.hotpop.com [38.113.3.71])
	by ozlabs.org (Postfix) with ESMTP id 44ADC2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Dec 2004 20:07:02 +1100 (EST)
Received: from gamebox.net (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4C32712E4CFF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Dec 2004 08:38:33 +0000 (UTC)
Received: from [192.168.0.7] (unknown [61.247.252.55])
	by smtp-3.hotpop.com (Postfix) with ESMTP id C100F12DCE27
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Dec 2004 08:38:16 +0000 (UTC)
Message-ID: <41CD26B8.10903@gamebox.net>
Date: Sat, 25 Dec 2004 14:07:12 +0530
From: Suresh Chandra Mannava <msuresh@gamebox.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: kernel for MPC8260 SBC
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

We developed a SBC based on MPC8260. We are planing to port Linux on it.
I downloaded mpc8260 cross compiling tools from denx.de.

I started cross-compiling linux-2.4.4.
The problem is
I am not able to compile kernel. 8260 specific files in arch/ppc are not 
compiling due to not inclusion of
"bd_t" structure. I Included the file "asm-ppc/bseip.h".
Still encountering many errors.

I even tried with linux-2.4.20 and encountered the same problems.
Is there any patch required for compiling the kernel cleanly.

or
I may need to provide board specific information in the form of header 
files?

Please provide pointer to the sutiable kernel along with patch.

We have configured serial port on SMC. For SMC, CPM is required.
But there is no option in the kernel to select SMC for serial port.

please educate me on the above issue.

Thanks & Regards,

Suresh Chandra Mannava
