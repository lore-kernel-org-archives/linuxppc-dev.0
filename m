Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408p190hTCzF1y3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 19:57:01 +1100 (AEDT)
In-Reply-To: <1521628323-14451-2-git-send-email-paulus@ozlabs.org>
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm-ppc@vger.kernel.org
Subject: Re: [v2,
 1/5] powerpc: Add CPU feature bits for TM bug workarounds on POWER9
 v2.2
Message-Id: <408p1869Nqz9s1b@ozlabs.org>
Date: Mon, 26 Mar 2018 19:57:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-21 at 10:31:59 UTC, Paul Mackerras wrote:
> This adds a CPU feature bit which is set for POWER9 "Nimbus" DD2.2
> processors which will be used to enable the hypervisor to assist
> hardware with the handling of checkpointed register values while the
> CPU is in suspend state, in order to work around hardware bugs.  The
> hardware assistance for these workarounds introduced a new hardware
> bug relating to the XER[SO] bit.  We add a separate feature bit for
> this bug in case future chips fix it while still requiring the
> hypervisor assistance with suspend state.
> 
> When the dt_cpu_ftrs subsystem is in use, the software assistance can
> be enabled using a "tm-suspend-hypervisor-assist" node in the device
> tree, and a "tm-suspend-xer-so-bug" node enables the workarounds for
> the XER[SO] bug.  In the absence of such nodes, a quirk enables both
> for POWER9 "Nimbus" DD2.2 processors.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b5af4f2793233cf37596e2c1f7b233

cheers
