Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DF741A0175
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 17:35:23 +1100 (AEDT)
In-Reply-To: <1448495096-24759-3-git-send-email-warrier@linux.vnet.ibm.com>
To: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de
Subject: Re: [v2,2/9] powerpc/smp: Add smp_muxed_ipi_set_message
Message-Id: <20151207063522.D22A3140319@ozlabs.org>
Date: Mon,  7 Dec 2015 17:35:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-25-11 at 23:44:49 UTC, "Suresh E. Warrier" wrote:
> smp_muxed_ipi_message_pass() invokes smp_ops->cause_ipi, which
> updates the MFFR through an ioremapped address, to cause the
> IPI. Because of this real mode callers cannot call
> smp_muxed_ipi_message_pass() for IPI messaging.

You're talking about the XICS code here but you don't mention that. Please
expand it to make it clear that you're talking about XICS.

cheers
