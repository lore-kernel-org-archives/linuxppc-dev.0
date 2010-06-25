Return-Path: <dkirjanov@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A44CAB6F10
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 19:40:04 +1000 (EST)
Message-ID: <4C24797C.6030703@kernel.org>
Date: Fri, 25 Jun 2010 13:40:12 +0400
From: Denis Kirjanov <dkirjanov@kernel.org>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] kvm/ppc: fix build warning
References: <20100624194415.GA24107@hera.kernel.org>
	<B5C3D944-F5D4-4DC1-BB7D-699CE10EDC15@suse.de>
	<4C2470AE.6090004@kernel.org>
In-Reply-To: <4C2470AE.6090004@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mtosatti@redhat.com, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Denis Kirjanov <dkirjanov@hera.kernel.org>, avi@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2010 01:02 PM, Denis Kirjanov wrote:
> On 06/25/2010 12:42 AM, Alexander Graf wrote:
>>
>> On 24.06.2010, at 21:44, Denis Kirjanov wrote:
>>
>>> Fix build warning:
>>> arch/powerpc/kvm/book3s_64_mmu.c: In function
>>> 'kvmppc_mmu_book3s_64_esid_to_vsid':
>>> arch/powerpc/kvm/book3s_64_mmu.c:446: warning: 'slb' may be used
>>> uninitialized in this function
>>> Signed-off-by: Denis Kirjanov<dkirjanov@kernel.org>
>>
>> Are you sure this isn't a broken compiler? I don't see where it could
>> be used uninitialized.
>
> I'm using gcc version 4.3.4 (Gentoo 4.3.4 p1.1, pie-10.1.5)
> slb pointer initialized inside conditional branch
> and used later in the case case MSR_DR|MSR_IR
>
This is based on linux-next tree (-next-20100623)
