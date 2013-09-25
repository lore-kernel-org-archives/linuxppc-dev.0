Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2861E2C0246
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 01:42:59 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 25 Sep 2013 21:12:56 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 044BA394004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 21:12:39 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8PFjEH940239130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 21:15:14 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8PFgrNJ014145
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 21:12:53 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
In-Reply-To: <87k3j8ejjq.fsf@linux.vnet.ibm.com>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
 <87haeh13s2.fsf@linux.vnet.ibm.com>
 <527D8312-EA18-4962-9069-B54FA738F5FA@suse.de>
 <87wqn9dtbi.fsf@linux.vnet.ibm.com>
 <932EC6E7-BC15-474F-9E8B-4321B2126BE4@suse.de>
 <87k3j8ejjq.fsf@linux.vnet.ibm.com>
Date: Wed, 25 Sep 2013 21:12:51 +0530
Message-ID: <87vc1odi10.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Alex,

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>>> Ok, please give me an example with real numbers and why it breaks.
>>>> 
>>>>> 
>>>>> http://mid.gmane.org/1376995766-16526-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com
>>>>> 
>>> 
>>> Didn't quiet get what you are looking for. As explained before, we now
>>> need to pass an array with array size 3 even though we know we need to
>>> read only 2 entries because kernel doesn't loop correctly.
>>
>> But we need to do that regardless, because newer QEMU needs to be able to run on older kernels, no?
>>
>
> yes. So use space will have to pass an array of size 3. But that should
> not prevent us from fixing this right ?
>

Do we still want this patch or should I drop this ?

-aneesh
