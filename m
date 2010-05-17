Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 883E9B7DB1
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 20:37:06 +1000 (EST)
Subject: Re: [PATCH]460EX on-chip SATA driver <Kernel 2.6.33> < resubmission >
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <201005171206.47566.sr@denx.de>
References: <201005051757.o45HvPmY005954@amcc.com>
	<4BED8BF1.5080800@ru.mvista.com> <1273966828.21352.670.camel@pasglop>
	<201005171206.47566.sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 May 2010 20:36:31 +1000
Message-ID: <1274092591.21352.722.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	linux-kernel@vger.kernel.org,
	Sergei Shtylyov <sshtylyov@mvista.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > Additionally, the boot wrapper should probably either remove the node or
> > at least use a status property "ok" / "disabled" to represent whether
> > the board is configured for SATA or PCIe x1...
> 
> U-Boot already sets the "status" property of the PCIe or SATA node 
> accordingly. Just let me know if this doesn't work for you.

That's probably enough.

Cheers,
Ben.
