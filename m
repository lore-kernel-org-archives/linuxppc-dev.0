Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp3.wanadoo.fr (smtp3.wanadoo.fr [193.252.22.28])
	by ozlabs.org (Postfix) with ESMTP id 80E7E67A73
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 04:11:36 +1100 (EST)
Date: Thu, 24 Feb 2005 18:01:50 +0100
To: Meelis Roos <mroos@linux.ee>
Message-ID: <20050224170150.GA7746@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net>
	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
	<20050224074728.GA31434@pegasos>
	<Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
	<20050224160657.GB11197@pegasos>
	<Pine.SOC.4.61.0502241832510.21289@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.SOC.4.61.0502241832510.21289@math.ut.ee>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>, Christian Kujau <evil@g-house.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
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

On Thu, Feb 24, 2005 at 06:34:03PM +0200, Meelis Roos wrote:
> >Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
> >meanwhile, you can try :
> >
> > http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd
> 
> This seems to work fine: onboard scsi is OK, pci nic with de4x5 is OK 
> too. Haven't got more PCI cards in there currently.

Ok, can you now install the 2.6.10-3 package from : 

  http://people.debian.org/~luther/powerpc/2.6.10-3 

(you need kernel-image-2.6.10-powerpc and mkvmlinuz), call mkvmlinuz on it (or
add it to kernel-img.conf as postinst_hook=/usr/sbin/mkvmlinuz).

You may probably want also to modify /etc/mkinitrd/mkinitrd:MODULES_DEP to dep
instead of MOST, or you may hit size problems with your initrd, i would be
interested in knowing that.

Then just dd your /boot/vmlinuz-2.6.10-powerpc to your prep partition, or
better yet to a tftp server, and try it out. If the scsi problems are there,
can you fill a bug report against kernel-source-2.6.10 ? 

Friendly,

Sven Luther
