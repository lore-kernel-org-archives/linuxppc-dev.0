Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 486412C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 22:27:07 +1000 (EST)
Subject: Re: [PATCH] kvm: powerpc: book3s: Fix build break for BOOK3S_32
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <EB193553-5B3C-4669-9C71-BACC6882D18B@suse.de>
Date: Fri, 4 Oct 2013 14:27:02 +0200
Message-Id: <36F00CBE-E313-465A-BD93-A8E1B96FD2A9@suse.de>
References: <1380724724-12892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20131003041415.GA2801@iris.ozlabs.ibm.com>
 <EB193553-5B3C-4669-9C71-BACC6882D18B@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.10.2013, at 14:23, Alexander Graf wrote:

>=20
> On 03.10.2013, at 06:14, Paul Mackerras wrote:
>=20
>> On Wed, Oct 02, 2013 at 08:08:44PM +0530, Aneesh Kumar K.V wrote:
>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>=20
>>> This was introduced by 85a0d845d8bb5df5d2669416212f56cbe1474c6b
>>=20
>> It's a good idea to give the headline of the commit as well as the =
ID.
>> I also like to trim the ID to 10 characters or so.  So it should look
>> like this:
>>=20
>> This was introduced by 85a0d845d8 ("KVM: PPC: Book3S PR: Allocate
>> kvm_vcpu structs from kvm_vcpu_cache").
>>=20
>>> arch/powerpc/kvm/book3s_pr.c: In function 'kvmppc_core_vcpu_create':
>>> arch/powerpc/kvm/book3s_pr.c:1182:30: error: 'struct =
kvmppc_vcpu_book3s' has no member named 'shadow_vcpu'
>>> make[1]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1
>>>=20
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>=20
>> Acked-by: Paul Mackerras <paulus@samba.org>
>=20
> Would you guys mind if I merge this into the offending patch? It's not =
trickled into -next yet, so rebasing should work.
>=20
> If not, please resend with the fixed commit message.

Eh - I must've missed v2 :). So that leaves only the question on whether =
you'd be ok to squash the patch instead. It'd help bisectability.


Alex
