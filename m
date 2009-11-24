Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 676861007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 02:04:23 +1100 (EST)
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4B0BF592.9020802@redhat.com>
Date: Tue, 24 Nov 2009 16:04:19 +0100
Message-Id: <A6B88177-8F90-4C87-B404-63078E3D3D2C@suse.de>
References: <1259049003-8028-1-git-send-email-agraf@suse.de>
	<4B0BF592.9020802@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 24.11.2009, at 16:02, Avi Kivity wrote:

> On 11/24/2009 09:50 AM, Alexander Graf wrote:
>> Currently userspace has no chance to find out which virtual address =
space we're
>> in and resolve addresses. While that is a big problem for migration, =
it's also
>> unpleasent when debugging, as gdb and the monitor don't work on =
virtual
>> addresses.
>>  =20
>=20
>> index 92045a9..1240fcb 100644
>> --- a/include/linux/kvm.h
>> +++ b/include/linux/kvm.h
>> @@ -492,6 +492,7 @@ struct kvm_ioeventfd {
>>  #ifdef __KVM_HAVE_VCPU_EVENTS
>>  #define KVM_CAP_VCPU_EVENTS 41
>>  #endif
>> +#define KVM_CAP_PPC_SEGSTATE 42
>>=20
>>  =20
>=20
> 42 is already taken (s390 psw and D. Adams), please use 43.

Aww. Any reason I didn't get the s390 patch in a git pull yet? (damn =
that Carsten - he got the cool number)

Alex
