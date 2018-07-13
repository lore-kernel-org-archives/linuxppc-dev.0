Return-Path: <jrdr.linux@gmail.com>
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RtB32wnvzF35T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 22:57:15 +1000 (AEST)
Received: by mail-lj1-x244.google.com with SMTP id 203-v6so13434558ljj.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 05:57:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <41Qft01FR3zB4MS@ozlabs.org>
References: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
 <41Qft01FR3zB4MS@ozlabs.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 13 Jul 2018 18:27:10 +0530
Message-ID: <CAFqt6zaBuJ=DRkDA4y4ecMzecGFXE0ddP2m9xfEXKHmnyFfcOQ@mail.gmail.com>
Subject: Re: misc: ocxl: Change return type for fault handler
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Matthew Wilcox <willy@infradead.org>, fbarrat@linux.vnet.ibm.com,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg KH <gregkh@linuxfoundation.org>, brajeswar.linux@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2018 at 6:54 PM, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
> On Mon, 2018-06-11 at 20:29:04 UTC, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> There is an existing bug when vm_insert_pfn() can return
>> ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
>> default. The new inline vmf_insert_pfn() has removed
>> this inefficiency by returning correct vm_fault_ type.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/a545cf032d11437ed86e62f00d4991
>
> cheers

Thanks :)
