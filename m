Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD2C5DDD08
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 11:39:33 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: /sys/devices/system/cpu/cpuX/online are missing
References: <20070311222652.5ea40da1.pochini@shiny.it>
	<20070312085826.GA9985@osiris.boeblingen.de.ibm.com>
	<Pine.LNX.4.64.0703122337350.25919@denise.shiny.it>
Date: Tue, 13 Mar 2007 01:39:25 +0100
In-Reply-To: <Pine.LNX.4.64.0703122337350.25919@denise.shiny.it> (Giuliano
	Pochini's message of "Mon, 12 Mar 2007 23:48:21 +0100 (CET)")
Message-ID: <je6496asea.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Giuliano Pochini <pochini@denise.shiny.it> writes:

> I had a look at arch/powerpc/kernel/smp.c but I'm not familiar at all with 
> those parts of the kernel.

See arch/powerpc/kernel/sysfs.c:topology_init.  I don't think there is
anything to do here.  You probably don't have CONFIG_HOTPLUG_CPU enabled.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
