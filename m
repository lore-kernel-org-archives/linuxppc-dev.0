Return-Path: <nyushchenko@dev.rtsoft.ru>
Received: from dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
 by ozlabs.org (Postfix) with ESMTP id 109132C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 23:41:11 +1100 (EST)
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
To: "=?utf-8?q?=E2=80=9Ctiejun=2Echen=E2=80=9D?=" <tiejun.chen@windriver.com>
Subject: Re: powerpc/hugetlb: BUG: using smp_processor_id() in preemptible
Date: Fri, 17 Jan 2014 16:41:02 +0400
References: <201401171323.52657@blacky.localdomain>
 <52D8F960.6030107@windriver.com>
In-Reply-To: <52D8F960.6030107@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201401171641.04553@blacky.localdomain>
Cc: Alexey Lugovskoy <lugovskoy@dev.rtsoft.ru>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Could you try this?
>
> powerpc/hugetlb: replace __get_cpu_var with get_cpu_var
>
> Replace __get_cpu_var safely with get_cpu_var to avoid
> the following call trace:

Confirmed, no more acktraces.

Nikita
