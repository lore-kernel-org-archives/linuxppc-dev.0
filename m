Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAB031A02B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 19:22:30 +1000 (EST)
Message-ID: <1402996939.7661.126.camel@pasglop>
Subject: Re: [PATCH] powerpc/kvm: support to handle sw breakpoint
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 17 Jun 2014 19:22:19 +1000
In-Reply-To: <53A0022D.5020108@suse.de>
References: <1402780097-28827-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53A0022D.5020108@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-17 at 10:54 +0200, Alexander Graf wrote:
> 
> Also, why don't we use twi always or something else that actually is 
> defined as illegal instruction? I would like to see this shared with 
> book3s_32 PR.

twi will be directed to the guest on HV no ? We want a real illegal
because those go to the host (for potential emulation by the HV). I'm
trying to see if I can get the architect to set one in stone in a future
proof way.

Cheers,
Ben.
