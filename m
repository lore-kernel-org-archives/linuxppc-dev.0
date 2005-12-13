Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 655916886E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 19:01:35 +1100 (EST)
From: "Heiko Schocher" <hs@denx.de>
To: "HappyPhot" <happyphot@gmail.com>
Date: Tue, 13 Dec 2005 09:01:16 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNAEFICEAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <003201c5ffb9$fe0d6310$0760120a@photon>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8245 with its internal UART
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

On Tuesday, December 13, 2005 8:51 AM HappyPhot wrote:
> Hi,
>   I get this one "linuxppc_2_4_devel-2005-10-25-1440.tar.bz2"
> and try "make CPC45_defconfig". But it shows "No rule to make target
>   ...." Did I do something wrong ?

Try "make CPC45_config"
It works fine on my PC ...

Bets regards,
Heiko
