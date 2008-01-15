Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 40754DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 15:15:42 +1100 (EST)
Message-ID: <478C336D.2080307@pikatech.com>
Date: Mon, 14 Jan 2008 23:15:41 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: emac/zmii link warnings
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I keep getting these link(?) warnings:

WARNING: vmlinux.o(.data+0x16178): Section mismatch: reference to .init.text:emac_of_bus_notify (between 'emac_of_bus_notifier' and 'emac_phy_map_lock')
WARNING: vmlinux.o(.init.text+0x16ba8): Section mismatch: reference to .exit.text:zmii_detach (between 'emac_probe' and 'zmii_probe')
WARNING: vmlinux.o(.init.text+0x16bb4): Section mismatch: reference to .exit.text:mal_unregister_commac (between 'emac_probe' and 'zmii_probe')

Any hints as to what might be wrong? Or are they "normal".

Cheers,
   Sean
