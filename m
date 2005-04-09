Return-Path: <antonio.corbi@ua.es>
Received: from aitana.cpd.ua.es (aitana.cpd.ua.es [193.145.233.5])
	by ozlabs.org (Postfix) with ESMTP id 0B6B367B4D
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 00:22:12 +1000 (EST)
Received: from aitana.cpd.ua.es (aitana.cpd.ua.es [193.145.233.5])
	by aitana.cpd.ua.es (8.12.11/8.12.11) with ESMTP id j39Drq43417058
	for <linuxppc-dev@ozlabs.org>; Sat, 9 Apr 2005 15:53:54 +0200
From: "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113006674.9568.414.camel@gaston>
References: <1113006674.9568.414.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 09 Apr 2005 15:54:01 +0200
Message-Id: <1113054841.5822.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

El sáb, 09-04-2005 a las 10:31 +1000, Benjamin Herrenschmidt escribió:
> Hi !
> 
> If you have a newer machine, that is a machine released on or after
> 2002, can you please send me the output of:

Hi Ben, this is a Powerbook 12" post feb-2005.

As you know sound does not work, the card seems to be recognized and the
module "snd_powermac" is loaded, sound-applications (rhythmbox, xmms,
bmp, totem, etc...) work but nothing can't be heard:

> echo `cat /proc/device-tree/model`

PowerBook6,8

> and
> 
> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done

/proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000/sound/layout-id
0000000 0000 0048
0000004

A. Corbi
