Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FxBV1PfZzF29d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 03:37:53 +1000 (AEST)
Received: by mail-ot0-x241.google.com with SMTP id j8-v6so12764406ota.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 10:37:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403142415.30083-3-oohall@gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
 <20180403142415.30083-3-oohall@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Apr 2018 10:37:51 -0700
Message-ID: <CAPcyv4jW5H8A96MFD7-UazNSZq-t1_NfrChNB3p9=somdBpsNw@mail.gmail.com>
Subject: Re: [RESEND v2 3/4] doc/devicetree: Persistent memory region bindings
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Device Tree <devicetree@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 3, 2018 at 7:24 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
> Add device-tree binding documentation for the nvdimm region driver.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> v2: Changed name from nvdimm-region to pmem-region.
>     Cleaned up the example binding and fixed the overlapping regions.
>     Added support for multiple regions in a single reg.
> ---
>  .../devicetree/bindings/pmem/pmem-region.txt       | 80 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pmem/pmem-region.txt

Device-tree folks, does this look, ok?

Oliver, is there any concept of a management interface to the
device(s) backing these regions? libnvdimm calls these "nmem" devices
and support operations like health status and namespace label
management.
