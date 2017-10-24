Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLmNG4tYXzDr25
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:17:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 01/25] powerpc: initial pkey plumbing
In-Reply-To: <20171019171117.GX5617@ram.oc3035372033.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-10-git-send-email-linuxram@us.ibm.com>
 <87lgk7kbu3.fsf@concordia.ellerman.id.au>
 <20171019171117.GX5617@ram.oc3035372033.ibm.com>
Date: Tue, 24 Oct 2017 10:17:26 +0200
Message-ID: <87inf53qp5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> On Thu, Oct 19, 2017 at 03:20:36PM +1100, Michael Ellerman wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>> 
>> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> > index 9fc3c0b..a4cd210 100644
>> > --- a/arch/powerpc/Kconfig
>> > +++ b/arch/powerpc/Kconfig
>> > @@ -864,6 +864,22 @@ config SECCOMP
>> >  
>> >  	  If unsure, say Y. Only embedded should say N here.
>> >  
>> > +config PPC64_MEMORY_PROTECTION_KEYS
>> 
>> That's pretty wordy, can we make it CONFIG_PPC_MEM_KEYS ?
>> 
>> I think you're a sufficient vim wizard to search and replace all
>> usages at once,
>
> I take that as a compliment for now ;)
>
>> if not I can do it before I apply the series.
>
> Will change it...just that I was trying to keep it similar to what intel
> has X86_INTEL_MEMORY_PROTECTION_KEYS

Yeah I realise that's why you chose that name, but I'd still prefer
something shorter. I don't think it matters that the CONFIG names are
slightly different between the arches, it's still pretty clear what it's
for I think.

cheers
