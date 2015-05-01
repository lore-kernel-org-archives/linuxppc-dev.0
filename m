Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x234.google.com (mail-yk0-x234.google.com
 [IPv6:2607:f8b0:4002:c07::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8772C1A0D6C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 04:47:07 +1000 (AEST)
Received: by ykft189 with SMTP id t189so20131774ykf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2015 11:47:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430493730.7979.58.camel@kernel.crashing.org>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 1 May 2015 13:46:44 -0500
Message-ID: <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Grant Likely <grant.likely@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 1, 2015 at 10:22 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2015-05-01 at 07:54 -0500, Rob Herring wrote:
>
>> The difference seems to be whether you allocate space or just point to
>> the FDT for various strings/data. Is that right?
>>
>> >    * of_fdt_add_subtree() is the introduced API to do the work.
>>
>> Have you looked at overlays and if so why do they not work for your purposes?
>>
>> Why do you need to do this with the flattened tree?
>
> The basic idea I asked Gavin to implement is that since the FW needs to
> provide a bunch of DT updates to Linux at runtime in the form of new
> nodes below an existing one, rather than doing it via some new/custom
> format, instead, have it send a bit of FDT blob to expand under an
> existing node.

Overlay = an FDT blob to graft into a live running system. Sounds like
the same thing.

> As for the details of Gavin implementation, I haven't looked at it in
> details yet so there might be issues there, however I don't know what
> you mean by "overlays", any pointer ?

CONFIG_OF_OVERLAY

http://events.linuxfoundation.org/sites/events/files/slides/dynamic-dt-keynote-v3.pdf

Rob
