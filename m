Return-Path: <ben@serosoft.com>
Received: from smtp-out2.blueyonder.co.uk (smtp-out2.blueyonder.co.uk
	[195.188.213.5]) by ozlabs.org (Postfix) with ESMTP id E64FA67A6B
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 22:31:10 +1000 (EST)
From: Ben Hill <ben@serosoft.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113006674.9568.414.camel@gaston>
References: <1113006674.9568.414.camel@gaston>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 13:13:49 +0100
Message-Id: <1113135229.5547.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
Reply-To: ben@serosoft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-04-09 at 10:31 +1000, Benjamin Herrenschmidt wrote:
> echo `cat /proc/device-tree/model`

PowerBook5,6

> 
> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done

find: /proc/device-tree/uni-n@f8000000/i2c@f8001000/i2c-bus@1/fan@5c/pulses/rev: No such file or directory
/proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000/sound/layout-id
0000000 0000 0046
0000004

HTH

-- 
ben@serosoft.com - www.seigan.org
PGP Key fingerprint = 4309 1C58 5143 AFAC F69E  11CD 76FD 56D4 1223 E387
