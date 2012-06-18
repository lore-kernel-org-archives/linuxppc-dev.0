Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B33D5B6FFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 06:51:18 +1000 (EST)
Message-ID: <1340052669.2372.37.camel@pasglop>
Subject: Re: [RFC/PATCH] i2c/powermac: Improve detection of devices from
 device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 19 Jun 2012 06:51:09 +1000
In-Reply-To: <m28vfkvkuz.fsf@igel.home>
References: <1340014606.2372.13.camel@pasglop> <m28vfkvkuz.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-18 at 14:57 +0200, Andreas Schwab wrote:
> These are the remaining failures on PowerMac7,3:
> 
> i2c i2c-5: No i2c address for /ht@0,f2000000/pci@1/mac-io@7/i2c@18000/i2c-modem
> i2c i2c-6: i2c-powermac: modalias failure on /u3@0,f8000000/i2c@f8001000/cereal@1c0

Right, those are known and harmless. I might add code to silence them.

Thanks for testing.

Cheers,
Ben.
