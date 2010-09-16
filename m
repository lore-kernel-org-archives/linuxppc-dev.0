Return-Path: <chris.friesen@genband.com>
Received: from exprod7og124.obsmtp.com (exprod7og124.obsmtp.com [64.18.2.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC66AB70F1
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 06:12:18 +1000 (EST)
Message-ID: <4C9278CD.10607@genband.com>
Date: Thu, 16 Sep 2010 14:06:37 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, timur@freescale.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org
Subject: linux support for freescale e5500 core?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

We're looking at maybe doing some work with an e5500-based system.  Is
there any support existing/planned for this core?

Also, do we know what the cache line size is--we have some legacy apps
that assume 32-byte.

Thanks,
Chris

-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
