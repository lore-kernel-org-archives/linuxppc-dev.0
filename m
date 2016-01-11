Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98F3B1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 00:11:49 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 06:11:46 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2920A19D8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 05:59:46 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BDBhBN20971770
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 13:11:43 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BDBfgA003119
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 08:11:43 -0500
Message-ID: <5693AA14.8050203@linux.vnet.ibm.com>
Date: Mon, 11 Jan 2016 18:41:48 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jan Stancek <jstancek@redhat.com>
CC: linuxppc-dev@lists.ozlabs.org, vdavydov@parallels.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, nacc@linux.vnet.ibm.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 Steve Best <sbest@redhat.com>, Gustavo Duarte <gduarte@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [BUG] PowerNV crash with 4.4.0-rc8 at sched_init_numa (related
 to commit c118baf80256)
References: <1258383100.6297154.1452380635681.JavaMail.zimbra@redhat.com>
 <5693978F.2040507@linux.vnet.ibm.com>
In-Reply-To: <5693978F.2040507@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/11/2016 05:22 PM, Raghavendra K T wrote:
> On 01/10/2016 04:33 AM, Jan Stancek wrote:
>> Hi,
>>
>> I'm seeing bare metal ppc64le system crashing early during boot
>> with latest upstream kernel (4.4.0-rc8):
>>
>
> Jan,
> Do you mind sharing the .config you used for the kernel.
> Not able to reproduce with the one that I have :(
>

Never mind.. I enabled DEBUG_PER_CPU_MAPS.. to hit that..
/me goes back..
