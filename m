Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D2D72C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 15:12:07 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 11 Apr 2013 10:39:03 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 23888E004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 10:43:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3B5BsHc11796750
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 10:41:54 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3B5BwY8000680
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 05:11:59 GMT
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V5 12/25] powerpc: Return all the valid pte ecndoing in
 KVM_PPC_GET_SMMU_INFO ioctl
In-Reply-To: <20130411032447.GU8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130411032447.GU8165@truffula.fritz.box>
Date: Thu, 11 Apr 2013 10:41:57 +0530
Message-ID: <874nfdodlu.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Thu, Apr 04, 2013 at 11:27:50AM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> Surely this can't be correct until the KVM H_ENTER implementation is
> updated to cope with the MPSS page sizes.

Why ? We are returning info regarding penc values for different
combination. I would guess qemu to only use info related to base page
size. Rest it can ignore right ?. Obviously i haven't tested this
part. So let me know if I should drop this ?

-aneesh
