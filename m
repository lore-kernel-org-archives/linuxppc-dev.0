Return-Path: <cedricduval@free.fr>
Received: from postfix2-c.free.fr (postfix2-c.free.fr [213.228.0.80])
	by ozlabs.org (Postfix) with ESMTP id 1F30067B44
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 23:11:05 +1000 (EST)
Received: from postfix4-2.free.fr (postfix4-2.free.fr [213.228.0.176])
	by postfix2-c.free.fr (Postfix) with ESMTP id CFBF7CCE9A6
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 15:11:01 +0200 (CEST)
Date: Sat, 9 Apr 2005 15:10:50 +0200
From: Cedric Duval <cedricduval@free.fr>
To: linuxppc-dev@ozlabs.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Message-ID: <20050409131049.GA4457@burk.free.fr>
References: <1113006674.9568.414.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1113006674.9568.414.camel@gaston>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Just in case you didn't note it before sending the Mini back to repair... :)

Benjamin Herrenschmidt wrote:
> echo `cat /proc/device-tree/model`

PowerMac10,1

> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done

/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/layout-id
0000000 0000 003a                              
0000004

Regards,
-- 
Cédric
