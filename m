Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3340F2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Oct 2013 00:24:19 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 4 Oct 2013 19:54:14 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6AE04125803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 19:54:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r94EQdcH34996294
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Oct 2013 19:56:39 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r94EOAmZ002197
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Oct 2013 19:54:10 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] kvm: powerpc: book3s: Fix build break for BOOK3S_32
In-Reply-To: <36F00CBE-E313-465A-BD93-A8E1B96FD2A9@suse.de>
References: <1380724724-12892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20131003041415.GA2801@iris.ozlabs.ibm.com>
 <EB193553-5B3C-4669-9C71-BACC6882D18B@suse.de>
 <36F00CBE-E313-465A-BD93-A8E1B96FD2A9@suse.de>
Date: Fri, 04 Oct 2013 19:54:07 +0530
Message-ID: <87li29ktbs.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 04.10.2013, at 14:23, Alexander Graf wrote:
>
>> 
>> On 03.10.2013, at 06:14, Paul Mackerras wrote:
>> 
>>> On Wed, Oct 02, 2013 at 08:08:44PM +0530, Aneesh Kumar K.V wrote:
>>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>> 
>>>> This was introduced by 85a0d845d8bb5df5d2669416212f56cbe1474c6b
>>> 
>>> It's a good idea to give the headline of the commit as well as the ID.
>>> I also like to trim the ID to 10 characters or so.  So it should look
>>> like this:
>>> 
>>> This was introduced by 85a0d845d8 ("KVM: PPC: Book3S PR: Allocate
>>> kvm_vcpu structs from kvm_vcpu_cache").
>>> 
>>>> arch/powerpc/kvm/book3s_pr.c: In function 'kvmppc_core_vcpu_create':
>>>> arch/powerpc/kvm/book3s_pr.c:1182:30: error: 'struct kvmppc_vcpu_book3s' has no member named 'shadow_vcpu'
>>>> make[1]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1
>>>> 
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> 
>>> Acked-by: Paul Mackerras <paulus@samba.org>
>> 
>> Would you guys mind if I merge this into the offending patch? It's not trickled into -next yet, so rebasing should work.
>> 
>> If not, please resend with the fixed commit message.
>
> Eh - I must've missed v2 :). So that leaves only the question on whether you'd be ok to squash the patch instead. It'd help bisectability.

Yes, it should be squashed if we can do that.

-aneesh
