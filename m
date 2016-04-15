Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-x22a.google.com (mail-yw0-x22a.google.com
 [IPv6:2607:f8b0:4002:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmjFK18YpzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Apr 2016 02:10:45 +1000 (AEST)
Received: by mail-yw0-x22a.google.com with SMTP id d68so141238103ywe.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 09:10:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160414013052.GA23214@gwshan>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <570E0E13.6080409@ozlabs.ru> <20160413234246.GA5330@gwshan>
 <8771729.bnzLL9sLJY@new-mexico> <20160414013052.GA23214@gwshan>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 15 Apr 2016 11:10:21 -0500
Message-ID: <CAL_JsqKc2i6rDGYXvEzQRJ4fxi=xqXTG4ngtNkFR+XkEaWDU1Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/45] powerpc/powernv: PCI hotplug support
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, dja@axtens.net
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2016 at 8:30 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Thu, Apr 14, 2016 at 09:57:32AM +1000, Alistair Popple wrote:
>>Hi Gavin,
>>
>><snip>
>>
>>> >Why exactly cannot EEH reset changes go to a smaller separate patchset
>>> >(before hotplug)?
>>> >
>>>
>>> As I explained before, the patchset's order is: PCI generic part,
>>> PowerNV PCI related, EEH related, device-tree part and hotplug driver.
>>>
>>> The EEH reset change is included in PATCH[37/45]. There is no point
>>> to reorder the patches.
>>
>>I don't understand all of the dependencies but if possible splitting the
>>series up into a set of smaller self-contained patch series makes things
>>easier to review and may make it easier for you to get this functionality
>>reviewed and accepted into upstream.
>>
>
> Thanks, Alistair. I will move those cleanup/refactor related patches
> to form a separate series which is expected to be merged first. That
> will helps the reviewers to focus on the patches with complicated
> changes as you suggested. Alexey, please let me know if that way is
> you like to see or not.

As I said last cycle, I'll happily take the DT refactoring patches
separately, but you have to tell me if you want me to apply them and
it has to be well before the merge window.

Rob
