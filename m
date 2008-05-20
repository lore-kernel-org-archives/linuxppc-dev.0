Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 2B668DDF26
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 20:58:55 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 51C5B150E37
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 12:58:48 +0200 (CEST)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-HRBK7HAuTG for <linuxppc-dev@ozlabs.org>;
	Tue, 20 May 2008 12:58:45 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id 8ABB7150E64
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 12:58:45 +0200 (CEST)
Date: Tue, 20 May 2008 12:58:44 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: linuxppc-dev@ozlabs.org
Subject: ppc -> powerpc : where is 11 min rtc update gone ?
Message-ID: <20080520105844.GA694@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,

I have a ARCH=powerpc linux-2.6.25-rc6 linux running with an i2c rtc chip,
and synchronized to a ntp server.

I noticed that my rtc chip does not get updated by the kernel, just like
it would be on all other architectures (included ppc).

Looking at the differences between ./arch/powerpc/kernel/time.c and
./arch/ppc/kernel/time.c, I see that 

		/*
		 * update the rtc when needed ...

code segement has disappeared
		
Is it expected to be done somewhere else (where ?) or is there another
good reason for this removal ?

Kind regards

Philippe
