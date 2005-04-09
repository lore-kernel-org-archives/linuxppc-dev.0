Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 900B467B54
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 10:32:48 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 10:31:14 +1000
Message-Id: <1113006674.9568.414.camel@gaston>
Mime-Version: 1.0
Subject: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

If you have a newer machine, that is a machine released on or after
2002, can you please send me the output of:

echo `cat /proc/device-tree/model`

and

for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done

If the later returns nothing, it's fine, just tell me.

I'm especially interested in the various models of G5 based machines. It
seems apple is having all sorts of very different sound HW setups on
those machines, and I'm trying to figure out exactly what is where based
on those infos and the darwin sources.

Ben.
