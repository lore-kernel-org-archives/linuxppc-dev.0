Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7F0AD1007DC
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:17 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGEDPY031447
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:13 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 00/30] Rework FSL MPC85xx/Pxxxx device trees
Date: Thu, 10 Nov 2011 10:13:43 -0600
Message-Id: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Posting this to get any feedback and review while I cleanup commit messages
and the such.

The general idea is to split out the SoC and IP blocks into their own files
that can be included to build up a board level device tree.  This allows us
to reduce overall duplication and forward looking maintenance when updating
device nodes.

I've dropped numerous cases of compatiables that are of form "CHIP-IPname-.."
so as to use the basic IP dts includes as much as possible.  In general this
is areas that drivers have not typically utilized.

I've moved all the changed .dts to a 4-cell MPIC IRQ and made other cleanups
that I'll comment on in the commit mesages.

- k
