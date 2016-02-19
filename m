Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBDB11A0682
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 14:18:03 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Feb 2016 13:18:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 510672CE805B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 14:17:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1J3Hk7632833706
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 14:17:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1J3HKHF009844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 14:17:22 +1100
Date: Fri, 19 Feb 2016 14:16:55 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru, dja@axtens.net,
 Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v8 42/45] drivers/of: Rename unflatten_dt_node()
Message-ID: <20160219031655.GA10818@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqJydgmkU=SGcr-0JHsYG8wXk5GEQCQXY7y+FHH2A0LZkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqJydgmkU=SGcr-0JHsYG8wXk5GEQCQXY7y+FHH2A0LZkw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 08:59:53AM -0600, Rob Herring wrote:
>On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> This renames unflatten_dt_node() to unflatten_dt_nodes() as it
>> populates multiple device nodes from FDT blob. No logical changes
>> introduced.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/of/fdt.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>
>Acked-by: Rob Herring <robh@kernel.org>
>
>I'm happy to take patches 40-42 for 4.6 if the rest of the series
>doesn't go in given they fix a separate problem. I just need to know
>soon (or at least they need to go into -next soon).
>

Thanks for quick response, Rob. It depends how much comments I will
receive for the powerpc/powernv part. Except that, all parts including
this one have been ack'ed. I can discuss it with Michael Ellerman.
By the way, how soon you need the decision to merge 40-42? If that's
one or two weeks later, I don't think the reivew on the whole series
can be done.

Also, I think you probably can merge 40-44 as they're all about
fdt.c. If they can be merged at one time, I needn't bother (cc)
you again if I need send a updated revision. Thanks for your
review.

Thanks,
Gavin

>Rob
>
