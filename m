Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4h34VJmzDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:15 +1000 (AEST)
In-Reply-To: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>, benh@kernel.crashing.org,
 paulus@samba.org, robh@kernel.org, geoff@infradead.org,
 tyreld@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: Re: powerpc/mpic: Cleanup irq vector accounting
Message-Id: <41Z4h32LnGz9s3Z@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-29 at 10:24:32 UTC, Bharat Bhushan wrote:
> Available vector space accounts ipis and timer interrupts
> while spurious vector was not accounted. Also later
> mpic_setup_error_int() escape one more vector, seemingly it
> assumes one spurious vector.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fca7bf946e31688edce446fdaa571c

cheers
