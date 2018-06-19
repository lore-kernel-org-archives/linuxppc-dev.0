Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4197KK4SdtzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 22:57:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Souptick Joarder <jrdr.linux@gmail.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 fbarrat@linux.vnet.ibm.com, Matthew Wilcox <willy@infradead.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, brajeswar.linux@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] misc: ocxl: Change return type for fault handler
In-Reply-To: <CAFqt6zY=rpak3NGUMcCupvLp_RCwLMCtwfnBBjLfSc+U2vQ3OQ@mail.gmail.com>
References: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
 <5c6942da-c847-c53a-a571-4ec96f2a993d@linux.ibm.com>
 <CAFqt6zY=rpak3NGUMcCupvLp_RCwLMCtwfnBBjLfSc+U2vQ3OQ@mail.gmail.com>
Date: Tue, 19 Jun 2018 22:57:24 +1000
Message-ID: <87wouvvsqz.fsf@concordia.ellerman.id.au>
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

Souptick Joarder <jrdr.linux@gmail.com> writes:
> On Thu, Jun 14, 2018 at 9:36 PM, Frederic Barrat <fbarrat@linux.ibm.com> =
wrote:
>> Le 11/06/2018 =C3=A0 22:29, Souptick Joarder a =C3=A9crit :
>>>
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>>
>>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>
>>> There is an existing bug when vm_insert_pfn() can return
>>> ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
>>> default. The new inline vmf_insert_pfn() has removed
>>> this inefficiency by returning correct vm_fault_ type.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> ---
>>
>>
>> Thanks!
>>
>> Tested and
>> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>
> Frederic, is this patch queued for 4.19 ?

Not yet, you're a bit early. 4.18-rc1 only came out the other day :)

Your patches are tracked here:

  http://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=3D67924


They should appear in 4.19 unless something conflicts with them.

cheers
