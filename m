Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-x22c.google.com (mail-yw0-x22c.google.com
 [IPv6:2607:f8b0:4002:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A5201A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:40:35 +1100 (AEDT)
Received: by mail-yw0-x22c.google.com with SMTP id e63so165829457ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Mar 2016 18:40:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160219031655.GA10818@gwshan>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqJydgmkU=SGcr-0JHsYG8wXk5GEQCQXY7y+FHH2A0LZkw@mail.gmail.com>
 <20160219031655.GA10818@gwshan>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 1 Mar 2016 20:40:12 -0600
Message-ID: <CAL_JsqJFacEMD6jwi=YsT83BTVp5Asjmw4nYU6Msct-DcR2W9Q@mail.gmail.com>
Subject: Re: [PATCH v8 42/45] drivers/of: Rename unflatten_dt_node()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
 Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 18, 2016 at 9:16 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Wed, Feb 17, 2016 at 08:59:53AM -0600, Rob Herring wrote:
>>On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>> This renames unflatten_dt_node() to unflatten_dt_nodes() as it
>>> populates multiple device nodes from FDT blob. No logical changes
>>> introduced.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>  drivers/of/fdt.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>>Acked-by: Rob Herring <robh@kernel.org>
>>
>>I'm happy to take patches 40-42 for 4.6 if the rest of the series
>>doesn't go in given they fix a separate problem. I just need to know
>>soon (or at least they need to go into -next soon).
>>
>
> Thanks for quick response, Rob. It depends how much comments I will
> receive for the powerpc/powernv part. Except that, all parts including
> this one have been ack'ed. I can discuss it with Michael Ellerman.
> By the way, how soon you need the decision to merge 40-42? If that's
> one or two weeks later, I don't think the reivew on the whole series
> can be done.

Well, it's been 2 weeks now. I need to know this week.

> Also, I think you probably can merge 40-44 as they're all about
> fdt.c. If they can be merged at one time, I needn't bother (cc)
> you again if I need send a updated revision. Thanks for your
> review.

I did not include 43 and 44 as they are only needed for the rest of your series.

Rob
