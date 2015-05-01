Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AE321A0D1F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 01:23:01 +1000 (AEST)
Message-ID: <1430493730.7979.58.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robherring2@gmail.com>
Date: Sat, 02 May 2015 01:22:10 +1000
In-Reply-To: <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2015-05-01 at 07:54 -0500, Rob Herring wrote:

> The difference seems to be whether you allocate space or just point to
> the FDT for various strings/data. Is that right?
> 
> >    * of_fdt_add_subtree() is the introduced API to do the work.
> 
> Have you looked at overlays and if so why do they not work for your purposes?
> 
> Why do you need to do this with the flattened tree?

The basic idea I asked Gavin to implement is that since the FW needs to
provide a bunch of DT updates to Linux at runtime in the form of new
nodes below an existing one, rather than doing it via some new/custom
format, instead, have it send a bit of FDT blob to expand under an
existing node.

As for the details of Gavin implementation, I haven't looked at it in
details yet so there might be issues there, however I don't know what
you mean by "overlays", any pointer ?

Cheers,
Ben.
