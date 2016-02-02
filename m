Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8AB11A006F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 17:48:37 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 2 Feb 2016 01:48:34 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 049E1C90042
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 01:48:30 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u126mVVG36241540
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 06:48:31 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u126mVGK005940
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 01:48:31 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Pranith Kumar <bobby.prani@gmail.com>, Mike <michael.heltne@gmail.com>
Cc: "open list\:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Failure on latest GIT - implicit declaration of function
 =?utf-8?Q?=E2=80=98pte=5Fswp=5Fclear=5Fsoft=5Fdirty=E2=80=99?=
In-Reply-To: <CAJhHMCA6wy=i=yD4S-D0-vRTAOadTbwEtarsawK0BLw23G2Shg@mail.gmail.com>
References: <CANtoAtNkjrJfac0nR7ay7LKToMf53KtpVZNv0+xabHn1QSwRkA@mail.gmail.com>
 <CAJhHMCA6wy=i=yD4S-D0-vRTAOadTbwEtarsawK0BLw23G2Shg@mail.gmail.com>
Date: Tue, 02 Feb 2016 12:18:27 +0530
Message-ID: <878u336210.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pranith Kumar <bobby.prani@gmail.com> writes:

> On Sun, Jan 31, 2016 at 8:01 PM, Mike <michael.heltne@gmail.com> wrote:
>> Building on ppc32
>>
>> In file included from fs/proc/task_mmu.c:14:0:
>> include/linux/swapops.h: In function =E2=80=98pte_to_swp_entry=E2=80=99:
>> include/linux/swapops.h:69:6: error: implicit declaration of function
>> =E2=80=98pte_swp_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
>>   if (pte_swp_soft_dirty(pte))
>>       ^
>> include/linux/swapops.h:70:9: error: implicit declaration of function
>> =E2=80=98pte_swp_clear_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>>    pte =3D pte_swp_clear_soft_dirty(pte);
>>          ^
>
> Can you try the patch posted here: https://lkml.org/lkml/2016/1/25/554
>

This patch didn't work for you ?

http://mid.gmane.org/1454086969-21074-1-git-send-email-aneesh.kumar@linux.v=
net.ibm.com

-aneesh
