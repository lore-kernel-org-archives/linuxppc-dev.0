Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB12BB6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 15:26:45 +1000 (EST)
Subject: Re: [patch 13/14] PCSPKR: Cleanup Kconfig dependencies
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ralf@linux-mips.org
In-Reply-To: <20110601180610.984881988@duck.linux-mips.net>
References: <20110601180456.801265664@duck.linux-mips.net>
	<20110601180610.984881988@duck.linux-mips.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Jun 2011 15:09:32 +1000
Message-ID: <1307596172.2874.268.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-alpha@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, "H. Peter
	Anvin" <hpa@zytor.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-01 at 19:05 +0100, ralf@linux-mips.org wrote:
> plain text document attachment
> (i8253-use-aux-symbol-for-pcspkr-config.patch)
> Lenghty lists of the kind "depends on ARCH1 || ARCH2 ... || ARCH123" are
> usually either wrong or too coarse grained.  Or plain an ugly sin.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> To: linux-kernel@vger.kernel.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
