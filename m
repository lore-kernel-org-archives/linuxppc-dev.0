Return-Path: <segher@gcc12.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	by ozlabs.org (Postfix) with ESMTP id 706EADDEE1
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 08:59:00 +1000 (EST)
Received: from gcc12.fsffrance.org ([87.98.193.184] ident=Debian-exim)
	by snail.fsffrance.org with esmtp (Exim 4.50) id 1JtW7c-0000F4-BJ
	for linuxppc-dev@ozlabs.org; Wed, 07 May 2008 00:58:56 +0200
Received: from segher by gcc12.fsffrance.org with local (Exim 4.63)
	(envelope-from <segher@gcc12.fsffrance.org>) id 1JtW7W-0001Lz-Hi
	for linuxppc-dev@ozlabs.org; Wed, 07 May 2008 00:58:50 +0200
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: Fix arch/ppc builds
Date: Wed,  7 May 2008 00:58:47 +0200
Message-Id: <1210114730-5047-1-git-send-email-segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


These three trivial patches make arch/ppc build again.


Segher
