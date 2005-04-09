Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mx1.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2940A67B54
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 10:53:59 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1113006674.9568.414.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Sat, 09 Apr 2005 02:53:50 +0200
In-Reply-To: <1113006674.9568.414.camel@gaston> (Benjamin Herrenschmidt's
	message of "Sat, 09 Apr 2005 10:31:14 +1000")
Message-ID: <jer7hkvkgx.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> echo `cat /proc/device-tree/model`

PowerMac7,3

> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done

/proc/device-tree/ht@0,f2000000/pci@1/mac-io@7/i2s@10000/i2s-a@0/sound/layout-id
0000000 0000 0024                              
0000004

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
