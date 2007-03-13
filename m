Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F36B4DDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 20:44:45 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: /sys/devices/system/cpu/cpuX/online are missing
References: <20070311222652.5ea40da1.pochini@shiny.it>
	<20070312085826.GA9985@osiris.boeblingen.de.ibm.com>
	<Pine.LNX.4.64.0703122337350.25919@denise.shiny.it>
	<je6496asea.fsf@sykes.suse.de>
	<20070313090350.GA9890@osiris.boeblingen.de.ibm.com>
Date: Tue, 13 Mar 2007 10:44:31 +0100
In-Reply-To: <20070313090350.GA9890@osiris.boeblingen.de.ibm.com> (Heiko
	Carstens's message of "Tue, 13 Mar 2007 10:03:50 +0100")
Message-ID: <jetzwpscjk.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: spyro@f2s.com, linuxppc-dev@ozlabs.org,
	Giuliano Pochini <pochini@denise.shiny.it>, rmk@arm.linux.org.uk,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Heiko Carstens <heiko.carstens@de.ibm.com> writes:

> On Tue, Mar 13, 2007 at 01:39:25AM +0100, Andreas Schwab wrote:
>> Giuliano Pochini <pochini@denise.shiny.it> writes:
>> 
>> > I had a look at arch/powerpc/kernel/smp.c but I'm not familiar at all with 
>> > those parts of the kernel.
>> 
>> See arch/powerpc/kernel/sysfs.c:topology_init.  I don't think there is
>> anything to do here.  You probably don't have CONFIG_HOTPLUG_CPU enabled.
>
> I was referring to arch/ppc not arch/powerpc.

Sorry, I missed that part.

> But it seems that arch/ppc doesn't support cpu hotplug anyway.

I think if there is no hotplug support then the file should not be created
in the first place.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
