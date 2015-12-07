Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6EBF1A0175
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 13:33:34 +1100 (AEDT)
Received: by ykdr82 with SMTP id r82so179929707ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Dec 2015 18:33:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5664ED0C.6060706@roeck-us.net>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_Jsq+BnPEKkRgQX4+e0MA9dKLVLhy8rVF25Fr9yXL2jp+WLA@mail.gmail.com>
 <1449446087.21036.1.camel@kernel.crashing.org> <5664ED0C.6060706@roeck-us.net>
From: Rob Herring <robherring2@gmail.com>
Date: Sun, 6 Dec 2015 20:33:13 -0600
Message-ID: <CAL_JsqKWtEkmdDyWKjOFdtgX5wx2f+xfJMFw4jmo05Z5Jo_ZYA@mail.gmail.com>
Subject: Re: [PATCH v7 45/50] drivers/of: Avoid recursively calling
 unflatten_dt_node()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 6, 2015 at 8:21 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 12/06/2015 03:54 PM, Benjamin Herrenschmidt wrote:
>>
>> On Sun, 2015-12-06 at 14:28 -0600, Rob Herring wrote:
>>>
>>>
>>> Do you plan to respin the OF parts at least soon? There's another
>>> problem Guenter found that of_fdt_unflatten_tree is not re-entrant due
>>> to "depth" being static and this series fixes that. So I'd rather
>>> apply this and avoid adding a mutex if possible.
>>
>>
>> Gavin is on vacation until next year.
>>
>
> That is a bit more than the timeline I am looking for.
>
> Rob, any chance to accept my patch for now ? After all, it can be
> reverted after the rework is complete, and it would be easier
> to apply to earlier kernels.

Yes, will do. It's only 4.1 and later that it should be marked for stable?

Rob
