Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA7F8679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 00:00:10 +1000 (EST)
Date: Mon, 23 May 2005 14:59:53 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org, "linux-atm-general@lists.sourceforge.net"
	<linux-atm-general@lists.sourceforge.net>
Message-Id: <20050523145953.3a2044ef.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Memory mapping the PHY on CR826
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

Does anyone here have *any* code for memory mapping the PM5350 ATM phy
on the Microsys CR826 board?

I've just purchased this board from Microsys and I'm trying to get the
atm8260 ATM device driver to work on it - unfortunately I cannot seem to
memory map the phy.  My current settings are:


  memctl->memc_or8 = 0xe0400ef4; // base 0xe0400000; default timings
  memctl->memc_br8 = 0xffff8821; // min banksize; 8bit port; GPCM local;
                                 //  bank valid

Has anybody done this already?

TIA,

Alex
