Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 6000367C4B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 06:43:18 +1100 (EST)
Date: Wed, 22 Nov 2006 20:36:33 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NTP time sync
Message-ID: <20061122203633.611acaa8@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, Kumar, Andi Kleen <ak@muc.de>, ralf@linux-mips.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk,
	davem@davemloft.net, kkojima@rr.iij4u.or.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



 wrto the in-kernel NTP synchronization,
 as discussed before [1], my opinion
 is that it should be done in userland.

 Keeping it in kernel implies subtle code
 in each of the supported architectures.

 So, if the arch maintainers agree, 
 I would suggest to schedule it for removal.

[1] http://lkml.org/lkml/2006/3/28/358


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
