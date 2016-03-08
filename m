Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCFCE1A0118
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 11:57:38 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 8 Mar 2016 10:57:36 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 59A9E3578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 11:57:31 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u280vNPF5308710
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2016 11:57:31 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u280uwN4013766
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2016 11:56:59 +1100
Date: Tue, 8 Mar 2016 11:56:33 +1100
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
Message-ID: <20160308005633.GA30023@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqJydgmkU=SGcr-0JHsYG8wXk5GEQCQXY7y+FHH2A0LZkw@mail.gmail.com>
 <20160219031655.GA10818@gwshan>
 <CAL_JsqJFacEMD6jwi=YsT83BTVp5Asjmw4nYU6Msct-DcR2W9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqJFacEMD6jwi=YsT83BTVp5Asjmw4nYU6Msct-DcR2W9Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 01, 2016 at 08:40:12PM -0600, Rob Herring wrote:
>On Thu, Feb 18, 2016 at 9:16 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> On Wed, Feb 17, 2016 at 08:59:53AM -0600, Rob Herring wrote:
>>>On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>>> This renames unflatten_dt_node() to unflatten_dt_nodes() as it
>>>> populates multiple device nodes from FDT blob. No logical changes
>>>> introduced.
>>>>
>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>> ---
>>>>  drivers/of/fdt.c | 14 +++++++-------
>>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>>Acked-by: Rob Herring <robh@kernel.org>
>>>
>>>I'm happy to take patches 40-42 for 4.6 if the rest of the series
>>>doesn't go in given they fix a separate problem. I just need to know
>>>soon (or at least they need to go into -next soon).
>>>
>>
>> Thanks for quick response, Rob. It depends how much comments I will
>> receive for the powerpc/powernv part. Except that, all parts including
>> this one have been ack'ed. I can discuss it with Michael Ellerman.
>> By the way, how soon you need the decision to merge 40-42? If that's
>> one or two weeks later, I don't think the reivew on the whole series
>> can be done.
>
>Well, it's been 2 weeks now. I need to know this week.
>
>> Also, I think you probably can merge 40-44 as they're all about
>> fdt.c. If they can be merged at one time, I needn't bother (cc)
>> you again if I need send a updated revision. Thanks for your
>> review.
>
>I did not include 43 and 44 as they are only needed for the rest of your series.
>

Rob, sorry for late reponse. I really expect this series to be merged to 4.6 and
I was checking reviewers' bandwidth to review it. Unfortunately, I didn't receive
any comments except yours until now. That means this series has to miss 4.6. Please
pick/merge 41 and 42 if no body has objection. Thanks again for your time on this.

Thanks,
Gavin
