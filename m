Return-Path: <root@danielinux.net>
Received: from ms004msg.fastwebnet.it (ms004msg.fastwebnet.it [213.140.2.58])
	by ozlabs.org (Postfix) with ESMTP id 344A467B2B
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 12:06:39 +1000 (EST)
From: Daniele Lacamera <root@danielinux.net>
To: linuxppc-dev@ozlabs.org
Date: Sat, 9 Apr 2005 03:06:33 +0100
References: <1113006674.9568.414.camel@gaston>
In-Reply-To: <1113006674.9568.414.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504090406.34820.root@danielinux.net>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
Reply-To: root@danielinux.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 09 April 2005 02:31, Benjamin Herrenschmidt wrote: 
> echo `cat /proc/device-tree/model`

PowerBook6,8

(the newest 1.5Ghz 12" powerbook)

> 
> and
> 
> for i in `find /proc/device-tree -name layout-id -print`; do echo $i 
&& hexdump -n4 $i; done


/proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000/sound/layout-id
0000000 0000 0048
0000004



-- 
Daniele Lacamera
root{at}danielinux.net
