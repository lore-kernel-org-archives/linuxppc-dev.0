Return-Path: <agraf@suse.com>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0BFE1400B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 22:43:34 +1100 (EST)
Message-ID: <533D4963.1070003@suse.com>
Date: Thu, 03 Apr 2014 13:43:31 +0200
From: Alexander Graf <agraf@suse.com>
MIME-Version: 1.0
To: Liu ping fan <kernelfans@gmail.com>, Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>	<8761pdk6x5.fsf@linux.vnet.ibm.com>	<C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
 <CAFgQCTs8LSXUi+AwxR9j+2-QRGw4EFZWx-JxktAnJ3VvwLJb9A@mail.gmail.com>
 <533D47CD.906@suse.com> <533D4834.7050306@suse.com>
In-Reply-To: <533D4834.7050306@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: kvm-devel <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.04.14 13:38, Alexander Graf wrote:
>
> On 03.04.14 13:36, Alexander Graf wrote:
>>
>> On 03.04.14 04:36, Liu ping fan wrote:
>>> Hi Alex, could you help to pick up this patch? since  v3.14 kernel can
>>> enable numa fault for powerpc.
>>
>> What bad happens without this patch? We map a page even though it was 
>> declared to get NUMA migrated? What happens next?
>>
>> I'm trying to figure out whether I need to mark this with a stable 
>> tag for 3.14.
>
> Also, what about the other uses of pre_present()?

Oh how I love to reply to myself. The patch doesn't apply to the latest 
code anymore either. Also please rework the wording of your patch 
subject and patch description to explain the actual problem at hand.


Alex
