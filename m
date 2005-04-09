Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3FB867B54
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 11:03:58 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jer7hkvkgx.fsf@sykes.suse.de>
References: <1113006674.9568.414.camel@gaston> <jer7hkvkgx.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 11:02:17 +1000
Message-Id: <1113008537.9567.424.camel@gaston>
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

On Sat, 2005-04-09 at 02:53 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > echo `cat /proc/device-tree/model`
> 
> PowerMac7,3
> 
> > for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done
> 
> /proc/device-tree/ht@0,f2000000/pci@1/mac-io@7/i2s@10000/i2s-a@0/sound/layout-id
> 0000000 0000 0024                              
> 0000004

Thanks.

Ben.
