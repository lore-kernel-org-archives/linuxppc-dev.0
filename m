Return-Path: <palves@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 8E0E3140082
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 21:22:16 +1000 (EST)
Message-ID: <537351DD.4010402@redhat.com>
Date: Wed, 14 May 2014 12:22:05 +0100
From: Pedro Alves <palves@redhat.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>	<1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>	<537252C0.6090005@redhat.com>	<53730326.6000400@linux.vnet.ibm.com>	<53735044.5030008@redhat.com>
 <CAEjGV6y8-zOtOgxcg-6viNQh-RuzQCAy8JvJ+m-dc7XQnAkJmA@mail.gmail.com>
In-Reply-To: <CAEjGV6y8-zOtOgxcg-6viNQh-RuzQCAy8JvJ+m-dc7XQnAkJmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: avagin@openvz.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
 michael@ellerman.id.au, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/14 12:18, Michael Neuling wrote:
> 
>> s390 actually screwed that, though it got away because
>> there's a bit in HWCAP to signal transactions support.  See:
>>
>>  https://sourceware.org/ml/gdb-patches/2013-11/msg00080.html
>>
>> Are you adding something to HWCAP too?
> 
> Yes but it's in HWCAP2

That's fine.

-- 
Pedro Alves
