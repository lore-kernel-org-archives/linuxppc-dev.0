Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A76D0B7E0D
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Apr 2010 06:40:50 +1000 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Kexec on FSL-Book-E, v4
Date: Sun,  4 Apr 2010 22:19:00 +0200
Message-Id: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The change from v3 is not to use TLB0 for the temporary 4KiB mapping.
Everything now hapens in TLB1. The equal mapping starts ESEL three since
ESEL one or two contains the temporary mapping.
Other bits are untouched.
     
Sebastian
