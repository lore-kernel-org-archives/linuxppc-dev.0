Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49FAE1A0175
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 13:21:10 +1100 (AEDT)
Subject: Re: [PATCH v7 45/50] drivers/of: Avoid recursively calling
 unflatten_dt_node()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rob Herring <robherring2@gmail.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_Jsq+BnPEKkRgQX4+e0MA9dKLVLhy8rVF25Fr9yXL2jp+WLA@mail.gmail.com>
 <1449446087.21036.1.camel@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Frank Rowand <frowand.list@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5664ED0C.6060706@roeck-us.net>
Date: Sun, 6 Dec 2015 18:21:00 -0800
MIME-Version: 1.0
In-Reply-To: <1449446087.21036.1.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/2015 03:54 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2015-12-06 at 14:28 -0600, Rob Herring wrote:
>>
>> Do you plan to respin the OF parts at least soon? There's another
>> problem Guenter found that of_fdt_unflatten_tree is not re-entrant due
>> to "depth" being static and this series fixes that. So I'd rather
>> apply this and avoid adding a mutex if possible.
>
> Gavin is on vacation until next year.
>

That is a bit more than the timeline I am looking for.

Rob, any chance to accept my patch for now ? After all, it can be
reverted after the rework is complete, and it would be easier
to apply to earlier kernels.

Thanks,
Guenter
