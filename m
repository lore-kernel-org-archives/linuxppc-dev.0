Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id DE8B2DDFA9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 20:03:54 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D03DA1C01F49
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:54:41 +0100 (CET)
Received: from lancy.denx.de (p4FE63FB4.dip.t-dialin.net [79.230.63.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id D59089021C
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:54:40 +0100 (CET)
Message-ID: <49BE13CE.6090902@grandegger.com>
Date: Mon, 16 Mar 2009 09:54:38 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] PowerPC: MPC85xx: TQM85xx: dts and defconfig fixes
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch series fixes some issues with the DTS files of the
TQM85xx modules and the defconfig for the TQM8548 modules.

The patches are against the "next" branch of Kumar's "powerpc" GIT tree.

Wolfgang.
