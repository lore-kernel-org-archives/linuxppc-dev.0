Return-Path: <nd@bplan-gmbh.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id 0623168577
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2005 16:45:18 +1000 (EST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Sven Luther <sl@bplan-gmbh.de>
In-Reply-To: <1129233624.4161.30.camel@localhost.localdomain>
References: <1129233624.4161.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 14 Oct 2005 08:50:19 +0200
Message-Id: <1129272619.4034.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14-rc3 1/1] chrp_pegasos_eth: Added Marvell
	Discovery II SRAM support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le jeudi 13 octobre 2005 à 22:00 +0200, Nicolas DET a écrit :
> Added proper entry to support the Marvell MV64361 (Marvell Discovery II)
> SRAM.
> 
> This feature may be used by the mv643xx_eth driver.
> 
> Signed-off-by: Nicolas DET <det.nicolas@free.fr)
> 

I hope the patch is ok now. I apologized for the text format issue.

By the way, I compiled and booted the 2.6.14-rc4. It feels a bit faster
than rc3 (maybe it's just an impression). I'm also glad the Firewire
supported has been improved since rc3.

Regards
Nicolas DET
