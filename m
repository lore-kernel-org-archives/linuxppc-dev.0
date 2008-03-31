Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 05DECDDF01
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 19:20:15 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 1FC9F227220
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 11:20:37 +0200 (CEST)
Received: from [10.0.30.2] (p5497F87C.dip.t-dialin.net [84.151.248.124])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 92AA590079
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 11:20:13 +0200 (CEST)
Message-ID: <47F0ACC7.9080709@grandegger.com>
Date: Mon, 31 Mar 2008 11:20:07 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Using FEC on a MPC5200 with default PHY configuration
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

is it possible to use the FEC on a MPC5200 with the default hardware PHY
configuration. I mean running the link with a default speed without
handling or even touching the PHY like U-Boot does. I removed the PHY
entries from the DTS file and disabled CONFIG_FEC_MPC52xx_MDIO but it
did not work.

Any help is appreciated, TIA.

Wolfgang.
