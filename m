Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id 3550967B17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 22:51:34 +1000 (EST)
Message-ID: <004d01c571a9$12dafb80$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Rober Hsu" <rober@opnet.com.tw>, <linuxppc-embedded@ozlabs.org>
References: <1118830434.4813.10.camel@orange.opnet.com.tw>
Date: Wed, 15 Jun 2005 08:52:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: How to change SDRAM from HYNIX to AMIC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Hi:
>
>     I used HY57641620 * 2 at my MPC852T, the ram size is 16M, Now i want
> to change to AMIC A43L3616-6 * 2 32M.
>
>     I modify my ppboot's as follow, but i don't know how to modfiy my
> sdram_table, anybody know what's the meaning of sdram_table?
>

The sdram_table is used to load the UPM, which drives the signals to SDRAM
on a clock by clock basis.  This is not simple, and getting it wrong can
cause
intermittent problems that are very hard to diagnose.  On the other hand,
the
changes required are probably minimal, but you'll need someone who knows
what they're doing to review the spec sheets for the new SDRAM and the UPM
table and make sure timing requirements are met.

Freescale has tools for free download that help with configuring the UPMs.

Mark Chambers
