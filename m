Return-Path: <akashkaul@deccanetworld.com>
Received: from gatekeeper.deccanetworld.com (unknown [202.56.251.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 897A267A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 17:24:24 +1100 (EST)
Received: from gatekeeper.deccanetworld.com (localhost [127.0.0.1])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id j2H67xRg024173
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Mar 2005 11:37:59 +0530
From: "akash kaul" <akashkaul@deccanetworld.com>
To: <srinivas.surabhi@wipro.com>, <linuxppc-embedded@ozlabs.org>
Date: Thu, 17 Mar 2005 11:45:25 +0530
Message-ID: <005d01c52ab8$b5bba5d0$1b69cb0a@BGCW0166>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <EF9B29C78F41FA488927FCBC7750AF0E011DA945@hyd-mdp-msg.wipro.com>
Subject: RE: LED driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi Surabhi,
 You basically have to write appropriate values into Port data register
corresponding to the GPIO pin to switch the led on or of. The register
can be accessed thru the immap pointer.(i.e internal memory map pointer
)look at the file include/asm-ppc/immap_cpm2.h relative to ur kernel
source base. You will find the mapped register variable in this file.

If you need to access this immap memory from userspace then u have to
make a system call to enter kernel space and access the immap memory.

Regards,
Akash Kaul





Hi,

I am working on the MPC8270 board having connected GPIO 3 lines
connected to 3 LEDs. So can any one help me in finding out the best
solution of controlling the LEDs from MVlinux (kernel and user space) or
any pointers who has done it before.


Thanks & Rgds
SS





Confidentiality Notice


The information contained in this electronic message and any attachments
to this message are intended
for the exclusive use of the addressee(s) and may contain confidential
or privileged information. If
you are not the intended recipient, please notify the sender at Wipro or
Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
