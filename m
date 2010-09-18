Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EA74B70AE
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 13:14:52 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 18 Sep 2010 13:14:38 +1000
Message-ID: <1284779678.30449.108.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-09-17 at 20:20 -0500, Timur Tabi wrote:
> I don't see any reason to limit it to GPL drivers.  Not only that, but
> then we'll have this:

I do

> EXPORT_SYMBOL(ppc_proc_freq);
> EXPORT_SYMBOL_GPL(ppc_tb_freq);
> 
> That just looks dumb. 

Right, so send a patch to fix the first one too :-)

Cheers,
Ben.
