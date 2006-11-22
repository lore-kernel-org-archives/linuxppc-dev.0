Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0E09567BF4
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 10:22:40 +1100 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1Gn1QN-0007AT-00
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 00:22:39 +0100
Date: Thu, 23 Nov 2006 00:22:39 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [OT] multiplatform kernel test request
Message-ID: <Pine.LNX.4.60.0611230018220.4456@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I've built a kernel for KuroboxHG that uses MULTIPLATFORM and also has 
CHRP and MBOOK enabled (uImage). Would be interesting to test if it REALLY 
would at least boot on any of those machines. Of course, it won't really 
work as all the drivers are, probably, missing, but if you specify a 
correct command line, maybe you'd get console output at least as far as 
"unable to mount root fs"... That would be already nice.

Thanks
Guennadi
---
Guennadi Liakhovetski
