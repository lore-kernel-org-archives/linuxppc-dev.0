Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 03173DDF3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 05:15:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: PCI target implementation on AMCC PPC CPUs
Date: Thu, 6 Sep 2007 12:15:08 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C022417D2@ehost011-3.exch011.intermedia.net>
In-Reply-To: <20070906184308.GA22380@ld0162-tx32.am.freescale.net>
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
	<20070906184308.GA22380@ld0162-tx32.am.freescale.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

Does somebody have any experience of using AMCC PPC chips (such as
PPC440ep) or any other PPC at all as PCI target (slave)? PPC440ep has
PCI-PLB bridge which certainly can be configured as slave. CPU will need
to do configuration and then I assume another CPU (PCI host) will be
able to access all memories via the bridge including peripherals'
controllers. Slave CPU involvement would be minimal then.

Can anybody point me to design like this or to that end to any SW design
where PPC CPU works as PCI slave?

Thanks,

Leonid.
