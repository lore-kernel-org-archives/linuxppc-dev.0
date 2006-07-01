Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 5727167A62
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 20:20:14 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1FwcaC-0002pd-00
	for <linuxppc-dev@ozlabs.org>; Sat, 01 Jul 2006 12:20:12 +0200
Date: Sat, 1 Jul 2006 12:20:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: ppc vs. powerpc status update, please
Message-ID: <Pine.LNX.4.60.0607011215260.7912@poirot.grange>
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

What's the _current_ trend with those 2 archs, specifically,respecting 
embedded boards, the make ARCH=powerpc ***_defconfig for a board under ppc 
"just should work" doesn't seem to hold and I didn't find any provisions 
for that. (I read in an earlier post it "should"). Are ppc platforms still 
supposed to migrate to under powerpc? I am not quite clear where to put 
all board-specific stuff then, in that post it was told "you almost don't 
need anything, just use device tree and a correct CPU support, and put 
your specific _drivers_ somewhere". How is it in reality?

Thanks
Guennadi
---
Guennadi Liakhovetski
