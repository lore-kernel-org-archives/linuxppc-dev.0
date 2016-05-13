Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5bB55pNSzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 13:36:29 +1000 (AEST)
Date: Fri, 13 May 2016 13:36:18 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Use privileged SPR number for MMCR2
Message-ID: <20160513033618.GB22018@oak.ozlabs.ibm.com>
References: <1463052551-18206-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463052551-18206-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2016 at 01:29:11PM +0200, Thomas Huth wrote:
> We are already using the privileged versions of MMCR0, MMCR1
> and MMCRA in the kernel, so for MMCR2, we should better use
> the privileged versions, too, to be consistent.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
