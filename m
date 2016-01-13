Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5AC91A0C86
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 10:54:14 +1100 (AEDT)
Received: by mail-yk0-x22a.google.com with SMTP id x67so509258240ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 15:54:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160113212008.GC3881@katana>
References: <1446642770-4681-50-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160113135426.GA29030@katana> <1452719886.8203.1.camel@ellerman.id.au>
 <20160113212008.GC3881@katana>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 13 Jan 2016 17:53:53 -0600
Message-ID: <CAL_JsqLaCMYMGLu_2aoXopgMHmT09xU1CSO4NZokMVUOZTPSJg@mail.gmail.com>
Subject: Re: [v7,49/50] drivers/of: Export OF changeset functions
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, aik@ozlabs.ru,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 13, 2016 at 3:20 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Jan 14, 2016 at 08:18:06AM +1100, Michael Ellerman wrote:
>> On Wed, 2016-01-13 at 14:54 +0100, Wolfram Sang wrote:
>> > On Thu, Nov 05, 2015 at 12:12:49AM +1100, Gavin Shan wrote:
>> > > The PowerNV PCI hotplug driver is going to use the OF changeset
>> > > to manage the changed device sub-tree. This exports those OF
>> > > changeset functions for that.
>> > >
>> > > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> > > Acked-by: Rob Herring <robh@kernel.org>
>> >
>> > I needed something like this, too [1] and rebased my series on top of
>> > this patch. So:
>> >
>> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> OK. This series is kind of in limbo, it might hit 4.6, but it might not. So if
>> you need this patch before then you should probably pull it in to your series,
>> or ask Rob to merge it pre-emptively.
>
> Yup, this is what I had in mind, too.

Given this has been on the list some time and still works, I've
applied this for 4.5. That should simplify dependencies for 4.6.

Rob
