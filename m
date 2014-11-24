Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B7C11A0281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 01:04:43 +1100 (AEDT)
Received: from mail-yh0-f45.google.com (mail-yh0-f45.google.com
 [209.85.213.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D604140180
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 01:04:42 +1100 (AEDT)
Received: by mail-yh0-f45.google.com with SMTP id f10so4274024yha.32
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2014 06:04:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <546F1367.4060301@linux.vnet.ibm.com>
References: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1415683597-22819-8-git-send-email-khandual@linux.vnet.ibm.com>
 <54647DA7.1070000@linux.vnet.ibm.com>
 <CAHj3AVna2H1VZvP0=Xjw9pqS+gRKR7_KH9FNhX3vUBFh7OU2wA@mail.gmail.com>
 <546F1367.4060301@linux.vnet.ibm.com>
Date: Mon, 24 Nov 2014 18:04:40 +0400
Message-ID: <CAOJe8K2ti=X4_C7GuNnoMAqPTut4GLkcvyBv3yT6w5Nbw9dczw@mail.gmail.com>
Subject: Re: [PATCH V4 7/8] powerpc, ptrace: Enable support for miscellaneous
 debug registers
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
 dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 Denis Kirjanov <kirjanov@gmail.com>, davej@redhat.com, tglx@linutronix.de,
 sukadev@linux.vnet.ibm.com, davem@davemloft.net, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/14, Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> On 11/14/2014 03:30 PM, Denis Kirjanov wrote:
>> On 11/13/14, Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
>>> > On 11/11/2014 10:56 AM, Anshuman Khandual wrote:
>>>> >> This patch enables get and set of miscellaneous debug registers
>>>> >> through
>>>> >> ptrace PTRACE_GETREGSET-PTRACE_SETREGSET interface by implementing
>>>> >> new
>>>> >> powerpc specific register set REGSET_MISC support corresponding to
>>>> >> the
>>>> >> new ELF core note NT_PPC_MISC added previously in this regard.
>>> >
>>> > Right now this one does not compile for "ppc64e_defconfig" and
>>> > "pmac32_defconfig" config options. The patch below will fix it
>>> > and would be part of next revision.
>> It would be great to have a test tool for that under
>> tools/testing/selftests/ptrace/
>>
>
> Hey Denis,
>
> I have already added one test case under selftests/powerpc/tm/ which
> will test all the newly added ELF core note based ptrace requests on
> powerpc. This test case is added as part of the next patch 8/8 in
> the series. Please let me know if the test case does not cover something
> you are looking for.

Oh, I've missed this one. Anyway, I'll wait the second version to test.

Thanks.

>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
