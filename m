Return-Path: <jrdr.linux@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418wxX5KMbzF0wM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:09:36 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id v84-v6so4914496lfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 22:09:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5c6942da-c847-c53a-a571-4ec96f2a993d@linux.ibm.com>
References: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
 <5c6942da-c847-c53a-a571-4ec96f2a993d@linux.ibm.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 19 Jun 2018 10:39:32 +0530
Message-ID: <CAFqt6zY=rpak3NGUMcCupvLp_RCwLMCtwfnBBjLfSc+U2vQ3OQ@mail.gmail.com>
Subject: Re: [PATCH] misc: ocxl: Change return type for fault handler
To: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>, fbarrat@linux.vnet.ibm.com,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 brajeswar.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 14, 2018 at 9:36 PM, Frederic Barrat <fbarrat@linux.ibm.com> wr=
ote:
>
>
> Le 11/06/2018 =C3=A0 22:29, Souptick Joarder a =C3=A9crit :
>>
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
>> ---
>
>
> Thanks!
>
> Tested and
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>
>

Frederic, is this patch queued for 4.19 ?
