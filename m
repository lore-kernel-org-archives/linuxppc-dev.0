Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id BCD812BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 20:26:16 +1100 (EST)
Message-ID: <1102585377.41b81e218d6df@webmail.televes.com:443>
Date: Thu,  9 Dec 2004 10:42:57 +0100
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Kernel 2.6.10 running on mpc8272ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi to all,

Finally I got my mpc8272ads board running the 2.6.20-rc1 kernel.
The trick was:

First, I had to comment out the BCSR modification for second UART
in m82xx_board_init function (arch/ppc/platforms/pq2ads.c). As
suggested by Dan Malek, MMU is still off at this point.

Second, the uboot bootargs must be modified from those used for
kernel 2.4. Now, the selected console has to be ttyCPM. This
was unnecesary in kernel 2.4, as correct console was selected
by default.

Best regards
