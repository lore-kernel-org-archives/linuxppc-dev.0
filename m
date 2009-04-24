Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFD48DE13F
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 17:08:38 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 5F2A21E66D0
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 03:58:50 -0300 (BRT)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id n-lpV9ERqeWz for <linuxppc-dev@ozlabs.org>;
	Fri, 24 Apr 2009 03:58:35 -0300 (BRT)
Received: from chagas.nectar.ath.cx (unknown [187.22.248.170])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id 8D48C1E66D3
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 03:58:30 -0300 (BRT)
Date: Fri, 24 Apr 2009 03:58:16 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Regarding the linkstation defconfig
Message-ID: <20090424065816.GA15525@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Guennadi, Kumar & Co.

Guennadi, since you seem to be the one responsible for the
linkstation/kurobox in the kernel, I would like to ask you a few things
that I couldn't quite understand. Please, forgive my ignorance here
while I ask you some things:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 01. why is anticipatory the default scheduler for linkstations when CFQ
     is the default scheduler for the rest of the kernel?

 02. since kuroboxes/linkstations are meant to store files, is there any
     reason why they don't have support for large blk devs enabled by
     default?

 03. why is CONFIG_MIGRATION enabled in such low memory devices?

 04. why is CONFIG_BLK_DEV_RAM enabled by default?

 05. why is SCSI_LOWLEVEL enabled, if no device under that tree is used?

 06. idem for CONFIG_NETDEV_10000.

 07. idem for CONFIG_WIRELESS.

 08. idem for CONFIG_HWMON.

 09. idem for CONFIG_CRYPTO_HW.

 10. any reason why CONFIG_VIDEO_OUTPUT_CONTROL is configured as a
     module?

 11. any reason why CIFS is not configured with extended attributes,
     while both ext3 and nfs are?

 12. wouldn't it be a good thing to enable CONFIG_PRINTK_TIME?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Perhaps similar remarks would apply to the other device that you
maintain? I forgot its name.

Again, please, forgive my ignorance here regarding the questions above.
I'm really looking for some clarification and to get things in shape
both on my systems and in the default kernel configuration, in general.


Thank you very much for your contributions, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
