Return-Path: <alexdeucher@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5FA51A173D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 23:05:49 +1000 (EST)
Received: from mail-qc0-x230.google.com (mail-qc0-x230.google.com
 [IPv6:2607:f8b0:400d:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2CA7114016A
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2014 23:05:48 +1000 (EST)
Received: by mail-qc0-f176.google.com with SMTP id r5so910690qcx.7
 for <linuxppc-dev@ozlabs.org>; Fri, 03 Oct 2014 06:05:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412313820.30859.2.camel@pasglop>
References: <1412210082.10667.2.camel@pasglop>
 <CADnq5_PhuFbRPgzAa_hEA1czTQjY9xdLFOWhL393DN4CYDnFng@mail.gmail.com>
 <1412313820.30859.2.camel@pasglop>
Date: Fri, 3 Oct 2014 09:05:46 -0400
Message-ID: <CADnq5_NGnVgmYb3uX2_7z71u4mVPxfx8Vyvp0=7Q=4oxW6S-MA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sound/radeon: Move 64-bit MSI quirk from arch to
 driver
From: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
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

On Fri, Oct 3, 2014 at 1:23 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-10-01 at 22:13 -0400, Alex Deucher wrote:
>
>> The attached updated patch only flags the affected asics.
>
> I need formal (email :-) permission to add your s-o-b (and From: while
> at it since you wrote most of it) for this patch. I'll then include
> it in my new series.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
