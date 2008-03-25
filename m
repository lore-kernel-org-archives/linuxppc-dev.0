Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id C432BDE067
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:15:17 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 5A199150E38
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 17:15:15 +0100 (CET)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CSWzhP-6iezy for <linuxppc-dev@ozlabs.org>;
	Tue, 25 Mar 2008 17:15:13 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id 9B2D5150E37
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 17:15:13 +0100 (CET)
Date: Tue, 25 Mar 2008 17:15:13 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linuxppc-dev@ozlabs.org
Subject: how to use head_fsl_booke.S:abort to restart
Message-ID: <20080325161513.GB15991@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I have a mpc8540 board that could reboot when driven by a ARCH=ppc linux,
but that hangs now in arch/powerpc/sysdev/fsl_soc.c:fsl_rstcr_restart when
asked to reboot with a ARCH=powerpc linux.

I have found that if I call arch/powerpc/kernel/head_fsl_booke.S:abort from
there, my board reboots correctly, but I feel that's not the right place
to put that call.  Where/how should I do that ?

Philippe

PS : Does arch/powerpc/sysdev/fsl_soc.c:fsl_rstcr_restart actually work
for mpc8540_ads boards ?
