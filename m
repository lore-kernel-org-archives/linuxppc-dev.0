Return-Path: <mroos@linux.ee>
Received: from math.ut.ee (math.ut.ee [193.40.36.2])
	by ozlabs.org (Postfix) with ESMTP id 4029067A7A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 07:55:44 +1100 (EST)
Date: Thu, 24 Feb 2005 22:51:45 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050224170150.GA7746@pegasos>
Message-ID: <Pine.SOC.4.61.0502242250050.21289@math.ut.ee>
References: <20041206185416.GE7153@smtp.west.cox.net>
	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
	<20050224074728.GA31434@pegasos>
	<Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
	<20050224160657.GB11197@pegasos>
	<Pine.SOC.4.61.0502241832510.21289@math.ut.ee>
	<20050224170150.GA7746@pegasos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Tom Rini <trini@kernel.crashing.org>, Sven Hartge <hartge@ds9.gnuu.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Kujau <evil@g-house.de>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Then just dd your /boot/vmlinuz-2.6.10-powerpc to your prep partition, or
> better yet to a tftp server, and try it out. If the scsi problems are there,
> can you fill a bug report against kernel-source-2.6.10 ?

Thanks for the new kernel. Just filed a bug report on 
kernel-source-2.6.10.

> You may probably want also to modify /etc/mkinitrd/mkinitrd:MODULES_DEP to dep
> instead of MOST, or you may hit size problems with your initrd, i would be
> interested in knowing that.

It worked without changing the module list, with 5.2M resulting vmlinuz.

-- 
Meelis Roos (mroos@linux.ee)
