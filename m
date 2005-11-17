Return-Path: <carlos@kenati.com>
Received: from mail.kenati.com (unknown [69.90.147.196])
	by ozlabs.org (Postfix) with ESMTP id D8C186877F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 11:00:47 +1100 (EST)
Received: from [192.168.1.67] (adsl-69-105-32-113.dsl.pltn13.pacbell.net
	[69.105.32.113])
	by mail.kenati.com (Postfix) with ESMTP id B807712F0009
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 15:39:04 -0800 (PST)
Message-ID: <437D14CF.5070000@kenati.com>
Date: Thu, 17 Nov 2005 15:39:59 -0800
From: Carlos Munoz <carlos@kenati.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Problems with fcc_enet driver for MPC8248 (2.6.12)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm working on an embedded board that is currently running kernel 2.4.28 
without any problems. However, I am trying to upgrade from kernel 2.4.28 
to kernel 2.6.12 and I'm unable to get the fcc_enet driver to work 
properly.
The fcc ports are connected to ethernet phy devices. The receive and 
transmitted data out of the ethernet phy devices is all 0xff.

I tried using the fcc_enet driver from the 2.4.28 kernel on the 2.6.12 
kernel but get the same results. This leads me to believe that the core 
initialization of the MPC8248 has changed on kernel 2.6.12.

Has anyone got the  fcc ports to work properly on the 2.6.12 kernel ? If 
yes, how ? Did the MPC8248 core initialization change ?

Thanks,


Carlos Munoz
