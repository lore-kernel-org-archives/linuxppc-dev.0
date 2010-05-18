Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0903B7D6F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 07:49:45 +1000 (EST)
Subject: Re: PATA/legacy IDE subsystem on PowerMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: JJDaNiMoTh <jjdanimoth@gmail.com>
In-Reply-To: <201005182116.04092.jjdanimoth@gmail.com>
References: <201005182116.04092.jjdanimoth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 May 2010 07:49:36 +1000
Message-ID: <1274219376.21352.857.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-05-18 at 21:16 +0200, JJDaNiMoTh wrote:
> Hello,
> 
> I hope I've posted to the right list.
> I'm the maintainer of the linux kernel in ArchlinuxPPC [1].
> 
> We actually set statically the support for the PowerMac on-board IDE support 
> (under ATA/ATAPI/MFM/RLL support (DEPRECATED) ), and the disk is recognized 
> correctly (hda*).
> If we try to remove this legacy support, enabling Serial ATA and Parallel ATA 
> drivers --> Apple PowerMac/PowerBook internal 'MacIO' IDE (NEW) statically, 
> the kernel doesn't recognize the partition on the HD. We tried different 
> powerbook, and the result is the same.
> 
> Because we haven't log, I take two photos [2] [3].
> 
> With legacy stuff, I used hda6 as root device: with PATA, neither hda{5,6,7} or 
> sda{5,6,7} work.
> As you can see from the photos, seems that the hd isn't attached to any device 
> under /dev.
> With request I could upload somewhere the configs (working and not working) 
> used, but they differ only for the things above.

Nothing obvious... the disk seem to be detected properly. Do you have
the support for mac partitions and the SCSI disk driver (BLK_DEV_SD)
enabled ?

Cheers,
Ben.

> Please let me in the right direction.
> Many thanks to all.
> 
> 
> [1] http://www.archlinuxppc.org
> [2] http://img268.imageshack.us/img268/5787/dsc04701x.jpg
> [3] http://img204.imageshack.us/img204/6476/dsc04701v.jpg
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
