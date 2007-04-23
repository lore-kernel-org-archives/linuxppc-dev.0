Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5927BDDF1C
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 18:24:53 +1000 (EST)
In-Reply-To: <20070422193017.GA27048@lixom.net>
References: <20070419073556.73A6BDDE4A@ozlabs.org>
	<e4520bd4be50f2884003a9421863627c@bga.com>
	<ca8197808a747b83c14461f6fec375db@kernel.crashing.org>
	<20070422193017.GA27048@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <829d8b36a3c78c662f29437c59290609@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 7/7] MPIC MSI backend
Date: Mon, 23 Apr 2007 10:24:45 +0200
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> mpic_htmsi deals with MSIs that come in over hypertransport
>> to the MPIC on CPC925/CPC945; this has nothing to
>> do with HT APICs.
>
> Maybe it should be named mpic_cpc9x5msi instead?

Yeah probably, esp. since there are more MSI sources
on those chips, not just HT; and if support for those
sources gets added later, it should go to this file :-)


Segher
