Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 07BC8B6FC2
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2012 22:10:11 +1000 (EST)
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
 by gw1.transmode.se (Postfix) with ESMTP id 5BFD925801D
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2012 14:00:31 +0200 (CEST)
Subject: MSR loses DE bit in 3.3, BDI2000 cant handle breakpoints?
To: linuxppc-dev@ozlabs.org
Message-ID: <OF00FC5182.FED0E75C-ONC1257A0D.003AA532-C1257A0D.0041F687@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 29 May 2012 14:00:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I cannot make simple break points using BDI2000 work in 3.3, abatro suggests that it
depends on MSR[DE] is cleared by the kernel. With the emulator I can see that
MSR[DE] is off quite often by just stopping at random times and looking at MSR so
it seems like the kernel is turning MSR[DE] off most of the time.
Anyone else having success debugging 3.3 with BDI2000?

This is on a P2010(E500/BOOKE) CPU.
