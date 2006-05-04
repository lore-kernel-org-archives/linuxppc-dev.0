Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E4BEC67B23
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 14:34:16 +1000 (EST)
Subject: Re: mpc8270 : i2c support
From: Heiko Schocher <hs@denx.de>
To: jean-francois simon <jfaslist@yahoo.fr>
In-Reply-To: <20060503205654.39188.qmail@web26605.mail.ukl.yahoo.com>
References: <20060503205654.39188.qmail@web26605.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Thu, 04 May 2006 06:34:15 +0200
Message-Id: <1146717255.6058.11.camel@Zeus.EmbLux>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
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

Hello jean-francois,

on Wed, 03 May 2006 22:56 jean-francois simon wrote:
> > Maybe you have to set other Portsettings in
> > drivers/i2c/busses/i2c-cpm2.c cpm2_iic_init() ... ?
> 
> Sorry, but where can i find this file? 

Sorry, I meant:
drivers/i2c/busses/i2c-mpc8260.c mpc8260_iic_init()

Best regards
Heiko
