Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.2.87])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDCCB2BD3C
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 21:37:30 +1000 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8EBbH5c028263
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 13:37:17 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4146D833.8040703@246tNt.com>
Date: Tue, 14 Sep 2004 13:38:27 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: 
Subject: [PATCH 0/9] Small updates for Freescale MPC52xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here is a bunch of small updates / fix for Freescale MPC52xx. Some of 
them are now required for a proper compilation.
They mostly only modify the mpc52xx specific code and not much common code.

Theses are in my tree since some time now and have been tested by 
several peoples.

As usual, a BK tree is available with all of theses changes :

bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending


Comments / Reports are welcome.


    Sylvain Munaut
