Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 834AEB6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 10:15:57 +1000 (EST)
Subject: Re: linux-next: build failure after merge of the final tree
	(powerpc related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20100716171920.51ce1b88.sfr@canb.auug.org.au>
References: <20100716171920.51ce1b88.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Jul 2010 10:15:41 +1000
Message-ID: <1279498541.10390.1773.camel@pasglop>
Mime-Version: 1.0
Cc: Martyn Welch <martyn.welch@ge.com>, linuxppc-dev@lists.ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-16 at 17:19 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allmodconfig) failed like this:
> 
> ERROR: "of_i8042_kbd_irq" [drivers/input/serio/i8042.ko] undefined!
> ERROR: "of_i8042_aux_irq" [drivers/input/serio/i8042.ko] undefined!
> 
> Presumably missing EXPORT_SYMBOLs ..

Thanks. I'll fix that up.

Cheers,
Ben.
