Return-Path: <joel@fabiotec.com>
Received: from mtaout5.barak.net.il (mtaout5.barak.net.il [212.150.49.175])
	by ozlabs.org (Postfix) with ESMTP id CB96CDDE32
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 04:32:36 +1100 (EST)
Received: from [192.168.200.140] ([62.90.35.117])
	by mtaout5.barak.net.il (Sun Java System Messaging Server 6.2-7.04
	(built Aug
	17 2006)) with ESMTP id <0JRY00CEIY06NI80@mtaout5.barak.net.il> for
	linuxppc-dev@ozlabs.org; Fri, 23 Nov 2007 19:02:32 +0200 (IST)
Date: Fri, 23 Nov 2007 19:02:23 +0200
From: Joel Rouch <joel@fabiotec.com>
Subject: sys_mpc83xx spi driver not probed
To: linuxppc-dev@ozlabs.org
Message-id: <4747079F.60703@fabiotec.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello

I have a custom 8349 ppc board. I have defined the spi master in the 
configuration.
While booting my board, I driver is well added and linked to platform 
bus, however I don't see that the probe entry point is reached.
I don't succeed to understand who is triggering the probe. Can someone 
point me to the right link or explain me how to force it ?

Thanks
