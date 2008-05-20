Return-Path: <bshtein@yahoo.com>
Received: from web50607.mail.re2.yahoo.com (web50607.mail.re2.yahoo.com
	[206.190.38.94]) by ozlabs.org (Postfix) with SMTP id 87FBEDDF9F
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 02:42:33 +1000 (EST)
Date: Tue, 20 May 2008 09:42:31 -0700 (PDT)
From: Boris Shteinbock <bshtein@yahoo.com>
Subject: RE: [PATCH] i2c: adds support for i2c bus on Freescale CPM1/CPM2
	controllers
To: jochen@scram.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <410191.3991.qm@web50607.mail.re2.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am currently doing port for already working PQ2 board (MPC8270) from "ppc" to "powerpc" architecture.
When initial port took place, the driver i2c-cpm that appeared on linuxppc list in the beginning of 2006 was used,
and it is working perfectly all this time.

However, when I am trying to use  the driver in your patch, I encountered the following  problem :
Your driver loads and probes perfectly well, however any attempt to read anything from the bus times out.
Receive never takes place. To make things works, If a user-space program is interrupted by ctrl-c while waiting for data, the driver enters an endless loop, that effectively kills the kernel.
can you suggest any solution for this problem?

I, also, suggest  moving BRG setup values  to the device tree instead of hard-coding them into the driver.


      
