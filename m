Return-Path: <thirumalai.p@datapatterns.co.in>
Received: from ns0.datapatterns.co.in (mx0.datapatterns.co.in [121.242.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 298F7B7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 21:18:00 +1100 (EST)
MIME-Version: 1.0
Date: Thu, 12 Nov 2009 15:45:07 +0530
From: "thirumalai.p" <thirumalai.p@datapatterns.co.in>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linuxppc dev <linuxppc-dev@lists.ozlabs.org>
Subject: MTD subsystem Initialization
Message-ID: <91206860dfd46581feee6d42ed900cc5@datapatterns.co.in>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,
      When i try to boot my MPC8640D based target on 2.6.30 kernel. My
target is having 1GB of RAM and 256 MB of Flash memory. I am passing the
partition information using OF Tree. During MTD subsystem initialization,
the following error message is displayed. "vmap allocation for size
268435456 failed". i found that this is due to ioremap failure which is
happening during the time of MTD initializtion.

Even thoogh HIGH_MEM support was enabled on the kernel, this is failing. 

Any configurations that need to be modified for this. 

I am using ELDK-4.0 for compilation.

Thank you
T.

**************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
*********** End of Disclaimer ***********DataPatterns ITS Group**********
