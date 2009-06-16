Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 30325B7086
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 17:00:03 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A319DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 17:00:01 +1000 (EST)
Subject: Re: linux-next: Linus/powerpc tree build warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090616162429.07e74e75.sfr@canb.auug.org.au>
References: <20090616162429.07e74e75.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 16:59:46 +1000
Message-Id: <1245135586.12400.104.camel@pasglop>
Mime-Version: 1.0
Cc: Suneel <suneelg@xilinx.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-16 at 16:24 +1000, Stephen Rothwell wrote:
> Hi Ben,
> 
> Today's linux-next build (powerpc ppc44x_defconfig) produced this warning:
> 
> drivers/video/xilinxfb.c: In function 'xilinxfb_assign':
> drivers/video/xilinxfb.c:328: warning: cast to pointer from integer of different size
> 
> Introduced by commit dac4ccfb64bcdd5b4c248ccc22903d67486573cd ("fbdev:
> Add PLB support and cleanup DCR in xilinxfb driver").

Known problem, a fix is currently being polished by Grant and John.

Cheers,
Ben.
