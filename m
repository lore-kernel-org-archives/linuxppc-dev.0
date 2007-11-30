Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B47E4DDE2E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 03:11:26 +1100 (EST)
Message-ID: <47503619.2010202@freescale.com>
Date: Fri, 30 Nov 2007 10:11:05 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI, PCI-X and PCI-Express support
	among others
References: <1196403038.569525.367459803520.qpush@grosgo>	<20071130141540.GA3117@lixom.net>	<51DE5987-D0DD-4E62-A99A-3D23ECFA9908@kernel.crashing.org>
	<20071130152742.GB4196@lixom.net>
In-Reply-To: <20071130152742.GB4196@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

> I normally do "quilt diff | checkpatch.pl -" when use quilt. You could
> similarly do "git diff HEAD | checkpatch.pl -". You'd always get the
> warning about missing signed-off-by though.

So do a "git log -p | checkpatch.pl -" instead? :-)

jdl
