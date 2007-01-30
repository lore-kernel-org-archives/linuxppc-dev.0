Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D412DE0E9
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 10:25:57 +1100 (EST)
Subject: Re: [PATCH 1/4] PS3: Move system bus to platform directory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45BFD2BB.1030008@am.sony.com>
References: <45BFD2BB.1030008@am.sony.com>
Content-Type: text/plain
Date: Wed, 31 Jan 2007 10:25:26 +1100
Message-Id: <1170199526.26655.346.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-30 at 15:20 -0800, Geoff Levand wrote:
> Move the PS3 system bus routines from drivers/ps3 to arch/powerpc/platforms/ps3.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
