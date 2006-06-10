Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 281DE67C90
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Jun 2006 04:45:53 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1Fp8Ma-0003Pg-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 10 Jun 2006 20:39:12 +0200
Date: Sat, 10 Jun 2006 20:39:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-embedded@ozlabs.org
Subject: sleep / wake-up
Message-ID: <Pine.LNX.4.60.0606102034230.3305@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

This is a complete newbie question - just like I am on powerpc. How does 
one put to sleep / wake up an embedded ppc (mpc8241) system? Notice, I've 
never done it (sleep / suspend) on x86 either, and I only have a VERY 
vague idea of what it's all about... But I'd read if I knew what and where 
- half an hour googleing didn't bring any positive results apart from 
links to pbbuttonsd, which mainly describes ppc / apple notebooks.

What I'd like to know is a bit of theory - kernel-level support and 
user-level utilities, as well as what one does practically to put a ppc to 
sleep / wake it up.

Thanks
Guennadi
---
Guennadi Liakhovetski
