Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FE101A06D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 19:44:58 +1000 (EST)
Message-ID: <53885315.2070004@suse.de>
Date: Fri, 30 May 2014 11:44:53 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: powerpc/pseries: Use new defines when calling h_set_mode
References: <1401106626-13130-1-git-send-email-paulus@samba.org>	<1401106626-13130-4-git-send-email-paulus@samba.org>	<5385E620.5090703@suse.de>	<1401342462.4116.4.camel@ale.ozlabs.ibm.com>	<1401344549.4116.8.camel@ale.ozlabs.ibm.com>	<BD1CF085-FEBC-4208-AD3F-C55DB002097F@suse.de>	<1401349547.4116.19.camel@ale.ozlabs.ibm.com>	<1401440207.29324.10.camel@concordia>	<1401441046.13479.2.camel@ale.ozlabs.ibm.com>	<53884BC6.8030904@suse.de>
 <CAEjGV6ym8pX6eOzcPb+CY7U-wDUSp5wKBOBuW3m1ZmKzSdhyfg@mail.gmail.com>
In-Reply-To: <CAEjGV6ym8pX6eOzcPb+CY7U-wDUSp5wKBOBuW3m1ZmKzSdhyfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.05.14 11:44, Michael Neuling wrote:
>
>
> >>>
> >>> Which header are these coming from, and why aren't we including 
> it? And is it
> >>> going to still build with CONFIG_KVM=n?
> >>
> >>  From include/asm/hvcall.h in the h_set_mode patch set I sent before.
> >>
> >> And yes it compiles with CONFIG_KVM=n fine.
> >
> >
> > Please split that patch into one that adds the definitions and one 
> that changes the KVM code to use those definitions. Both Ben and me 
> can then apply the definition patch and our respective tree patch.
> >
>
> Why don't you just take the original h_set_mode patch and I'll repost 
> this cleanup later to ben when yours is upstream.  This cleanup patch 
> is not critical to anything and it avoid more churn.
>

That works too, but please keep in mind that my path to upstream is much 
longer than what you're used to ;).


Alex
