Return-Path: <eha@doredevelopment.dk>
Received: from bq8.dotserv.com (bq8.dotserv.com [193.201.35.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51494DDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 19:05:23 +1000 (EST)
Received: from bq8.dotserv.com (localhost [127.0.0.1])
	by bq8.dotserv.com (8.13.1/8.13.1) with ESMTP id l7V8xlKH005785
	for <linuxppc-embedded@ozlabs.org>; Fri, 31 Aug 2007 10:59:47 +0200
To: linuxppc-embedded@ozlabs.org
Subject: U-Boot + Linux 2.6 on MPC8270
MIME-Version: 1.0
Date: Fri, 31 Aug 2007 10:59:47 +0200
From: eha <eha@doredevelopment.dk>
Message-ID: <7249d63472c0dcdda1fc240edacc96ab@127.0.0.1>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi

I need to get a rather current kernel (2.6.22.3 to be precise) to boot on a MPC8270 based embedded target.
What is the right way to adapt to the devtree approach of arch/powerpc?  I have an old U-Boot (1.1.2) running on target, able to boot 2.4 kernels.

Best regards,
Esben Haabendal
