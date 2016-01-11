Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C88091A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 22:52:43 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 04:52:41 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 610C93E40041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 04:52:39 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BBqd0R25035000
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 04:52:39 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BBqcEp000596
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 04:52:39 -0700
Message-ID: <5693978F.2040507@linux.vnet.ibm.com>
Date: Mon, 11 Jan 2016 17:22:47 +0530
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
In-Reply-To: <1258383100.6297154.1452380635681.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/10/2016 04:33 AM, Jan Stancek wrote:
> Hi,
>
> I'm seeing bare metal ppc64le system crashing early during boot
> with latest upstream kernel (4.4.0-rc8):
>

Jan,
Do you mind sharing the .config you used for the kernel.
Not able to reproduce with the one that I have :(
