Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (smtp1.it.da.ut.ee [193.40.5.66])
	by ozlabs.org (Postfix) with ESMTP id 7415367A7D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 03:35:10 +1100 (EST)
Received: from sun5.it.da.ut.ee (sun5.it.da.ut.ee [193.40.5.164])
	by smtp1.it.da.ut.ee (Postfix) with ESMTP id 28D4B4C047A1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 18:35:09 +0200 (EET)
Received: from sun5.it.da.ut.ee (localhost [127.0.0.1])
	by sun5.it.da.ut.ee (8.12.10+Sun/8.12.10) with SMTP id j1OGYmNS001590
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 18:34:55 +0200 (EET)
Received: from sun5.it.da.ut.ee ([127.0.0.1])
	by sun5.it.da.ut.ee (SMSSMTP 4.0.0.59) with SMTP id
	M2005022418341210566
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 18:34:54 +0200
Received: from math.ut.ee (math.ut.ee [193.40.5.125])
	by sun5.it.da.ut.ee (8.12.10+Sun/8.12.10) with ESMTP id j1OGYCrx001500
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 18:34:13 +0200 (EET)
Date: Thu, 24 Feb 2005 18:34:03 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050224160657.GB11197@pegasos>
Message-ID: <Pine.SOC.4.61.0502241832510.21289@math.ut.ee>
References: <20041206185416.GE7153@smtp.west.cox.net>
	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
	<20050224074728.GA31434@pegasos>
	<Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
	<20050224160657.GB11197@pegasos>
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

> Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
> meanwhile, you can try :
>
>  http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd

This seems to work fine: onboard scsi is OK, pci nic with de4x5 is OK 
too. Haven't got more PCI cards in there currently.

-- 
Meelis Roos (mroos@linux.ee)
