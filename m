Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5E17679F4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 01:15:08 +1000 (EST)
Received: from zambia.cambridgebroadband.com (cbluk-gw0.cambridgebroadband.com
	[217.204.121.82])
	by cambridgebroadband.com (8.12.8/8.12.8) with SMTP id j4GFF3G2032609
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 May 2005 16:15:04 +0100
Date: Mon, 16 May 2005 16:15:03 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20050516161503.0081b1b0.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Missing m8260_cpm_dpfree()
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

I have a question about the MPC8260 dual port RAM allocation routines.

In arch/ppc/8260_io/commproc.c this is a  m8260_cpm_dpalloc() routine,
but the m8260_cpm_dpfree() routine is missing.  Does anybody know where
I can find this?

I am using denx's linuxppc_2_4_devel tree from 2005-03-06.

TIA,

Alex
