Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8940C1A1865
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 15:24:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB9CE14016A
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2014 15:24:07 +1000 (EST)
Message-ID: <1412313820.30859.2.camel@pasglop>
Subject: Re: [PATCH v2 3/4] sound/radeon: Move 64-bit MSI quirk from arch to
 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 03 Oct 2014 15:23:40 +1000
In-Reply-To: <CADnq5_PhuFbRPgzAa_hEA1czTQjY9xdLFOWhL393DN4CYDnFng@mail.gmail.com>
References: <1412210082.10667.2.camel@pasglop>
 <CADnq5_PhuFbRPgzAa_hEA1czTQjY9xdLFOWhL393DN4CYDnFng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Linux PCI <linux-pci@vger.kernel.org>, Anton Blanchard <anton@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Yijing Wang <wangyijing@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 22:13 -0400, Alex Deucher wrote:

> The attached updated patch only flags the affected asics.

I need formal (email :-) permission to add your s-o-b (and From: while
at it since you wrote most of it) for this patch. I'll then include
it in my new series.

Cheers,
Ben.
