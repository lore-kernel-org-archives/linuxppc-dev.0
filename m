Return-Path: <darenh@4bridgeworks.com>
Received: from ntserver4.diluk.co.uk (mailhost.digitalinterfacesltd.com
	[62.69.87.37]) by ozlabs.org (Postfix) with ESMTP id 8F10F2BC0F
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 00:59:55 +1000 (EST)
Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD4502941E7@NTSERVER4>
From: Daren Hayward <darenh@4bridgeworks.com>
To: "'jonathan@jonmasters.org'" <jonathan@jonmasters.org>,
	linuxppc <linuxppc@4bridgeworks.com>
Date: Thu, 21 Oct 2004 15:59:42 +0100
MIME-Version: 1.0
Content-Type: text/plain
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: RE: Problem with PPC 440 GX Transmit Path
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Perhaps *any* form of useful output or description would be useful.
> Could you please provide the specific line of debugging that you need
> to retain at least?

Amy of the following

PKT_DEBUG(("emac_txeob_dev() entry, tx_cnt %d", fep->tx_cnt));
PKT_DEBUG(("emac_txeob_dev() exit, tx_cnt %d", fep->tx_cnt));
PKT_DEBUG(("emac_start_xmit() exitn"));

Daren
