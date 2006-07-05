Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC9B967B53
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jul 2006 09:16:26 +1000 (EST)
Subject: Re: [PATCH] Fix snd-aoa irq conversion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jeirmbn76v.fsf@sykes.suse.de>
References: <jeirmbn76v.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 09:16:15 +1000
Message-Id: <1152141375.24632.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-07-05 at 22:11 +0200, Andreas Schwab wrote:
> Use proper irq mapping interface for snd-aoa-i2sbus.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

One could argue that the "proper" fix is to update macio_asic.c to
register the sub-nodes i2s-X as individual devices. That would also
allow to move the various resource workarounds there along with others
and simplify the code in snd-aoa.

Ben.
