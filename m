Return-Path: <ynkim@adics.com>
Received: from localhost.localdomain (unknown [210.205.117.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B244679EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 17:28:31 +1000 (EST)
Message-ID: <4445DB5E.6010808@adics.com>
Date: Wed, 19 Apr 2006 15:40:30 +0900
From: =?EUC-KR?B?sei/tbOy?= <ynkim@adics.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: I want to use SCC3 as ethernet with SMC1 as console(mpc8xx)
Content-Type: text/plain; charset=EUC-KR
Reply-To: ynkim@adics.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

First of all, I am sorry for my poor english.

I have mpc850 custom board with followings:

SMC1 - console
SMC2 - uart
SCC2 - ethernet

I want to use SCC2 and SCC3 as ethernet(two ethernet interfaces).

As many web sites and mailing lists describe, I knew that SMC patch is
required because SMC1 and SCC3 share parameter ram.

I have DENX 2.4.25 kernel and this kernel works fine except using SCC3
as ethernet.
When apply "USE_SMC_PATCH" in arch/ppc/8xx_io/micropatch.c, kernel hang
and reset without any messages.(using u-boot 1.1.4)

I want to know that when I use "USE_SMC_PATCH", which source file is
modified and how to modify source file to use SMC1 as console.

Could you tell me useful information about that?
