Return-Path: <kernelfans@gmail.com>
Received: from mail-yk0-x232.google.com (mail-yk0-x232.google.com
 [IPv6:2607:f8b0:4002:c07::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21D991A07D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 16:47:43 +1100 (AEDT)
Received: by mail-yk0-f178.google.com with SMTP id 20so3620074yks.37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 21:47:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <544DE9B0.2050500@linux.vnet.ibm.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-12-git-send-email-kernelfans@gmail.com>
 <544DE9B0.2050500@linux.vnet.ibm.com>
Date: Tue, 18 Nov 2014 13:47:41 +0800
Message-ID: <CAFgQCTt6NDtsmmw4p3EigjzcpWQdZCxx9qZqQwin32fTF0pKaA@mail.gmail.com>
Subject: Re: [RFC 11/11] powerpc: kvm: Kconfig add an option for enabling
 secondary hwthread
From: Liu ping fan <kernelfans@gmail.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2014 at 2:44 PM, Preeti U Murthy
<preeti@linux.vnet.ibm.com> wrote:
> On 10/17/2014 01:00 AM, kernelfans@gmail.com wrote:
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kvm/Kconfig | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
>> index 602eb51..de38566 100644
>> --- a/arch/powerpc/kvm/Kconfig
>> +++ b/arch/powerpc/kvm/Kconfig
>> @@ -93,6 +93,10 @@ config KVM_BOOK3S_64_HV
>>
>>         If unsure, say N.
>>
>> +config KVMPPC_ENABLE_SECONDARY
>> +     tristate "KVM support for running on secondary hwthread in host"
>> +     depends on KVM_BOOK3S_64_HV
>
> This patch is required ontop of all the rest :) The top patches won't
> compile without this one. Every patch in the patchset should be able to
> compile successfully without the aid of the patches that come after it.
>
I think here is a conflict. If we do so, then we should make effort to
prevent the independent patch to take effect before the whole patchset
is applied.

Thx,
Fan

> Regards
> Preeti U Murthy
>
