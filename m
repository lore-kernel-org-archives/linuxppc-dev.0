Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F2F62C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 02:24:19 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Kumar
 Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Clearing DBSR and DBCR0 in host handler.
Date: Wed, 3 Apr 2013 15:24:09 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D06FBE661@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

The kernel exception handling code for 32 bit (transfer_to_handler in entry=
_32.S) clear DBSR and load DBCR0 with 0 (global_dbcr0 variable, which is ze=
ro) if user space used debug (DBCR0.IDM set).

But I do not same (clearing DBCR0 and DBSR) in 64bit exception handler. Is =
this an issue or I am missing something?

Thanks
-Bharat
