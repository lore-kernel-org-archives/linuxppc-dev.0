Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF3F0B6F06
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 06:50:00 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix DEBUG_HIGHMEM build break from d4515646699
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20091130175750.GD2937@zod.rchland.ibm.com>
References: <1259015333-23485-1-git-send-email-beckyb@kernel.crashing.org>
	<20091130175750.GD2937@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Dec 2009 06:49:43 +1100
Message-ID: <1259610583.2076.97.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-11-30 at 12:57 -0500, Josh Boyer wrote:
> On Mon, Nov 23, 2009 at 04:28:53PM -0600, Becky Bruce wrote:
> >Code was added to mm/higmem.c that depends on several
> >kmap types that powerpc does not support.  We add dummy
> >invalid definitions for KM_NMI, KM_NM_PTE, and KM_IRQ_PTE.
> >
> >According to list discussion, this fix should not be needed
> >anymore starting with 2.6.33.  The code is commented to this
> >effect so hopefully we will remember to remove this.
> >
> >Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> 
> Ben, I see you have this queued up in you 'next' branch, but this seems to be
> impacting 2.6.32 and according to the comments won't be needed in 2.6.33.
> Right now, 2.6.32 doesn't build for a general Fedora ppc32 kernel because of
> this bug.  Should this be sent to Linus for .32?

Why would fedora have DEBUG_HIGHMEM enabled ? I'll see what I can do.

> ( http://ppc.koji.fedoraproject.org/koji/getfile?taskID=31439&name=build.log
> for the curious among you that want to look at the build log)

Cheers,
Ben.
