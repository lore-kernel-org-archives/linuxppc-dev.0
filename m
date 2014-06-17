Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F33FD1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 19:25:05 +1000 (EST)
Message-ID: <53A0096D.3020108@suse.de>
Date: Tue, 17 Jun 2014 11:25:01 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/kvm: support to handle sw breakpoint
References: <1402780097-28827-1-git-send-email-maddy@linux.vnet.ibm.com>	
 <53A0022D.5020108@suse.de> <1402996939.7661.126.camel@pasglop>
In-Reply-To: <1402996939.7661.126.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 17.06.14 11:22, Benjamin Herrenschmidt wrote:
> On Tue, 2014-06-17 at 10:54 +0200, Alexander Graf wrote:
>> Also, why don't we use twi always or something else that actually is
>> defined as illegal instruction? I would like to see this shared with
>> book3s_32 PR.
> twi will be directed to the guest on HV no ? We want a real illegal
> because those go to the host (for potential emulation by the HV).

Ah, good point. I guess we need different one for PR and HV then to 
ensure compatibility with older ISAs on PR.


Alex

> I'm
> trying to see if I can get the architect to set one in stone in a future
> proof way.
>
> Cheers,
> Ben.
>
