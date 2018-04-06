Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Hp9h12W2zF1wk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 04:28:27 +1000 (AEST)
Received: by mail-ot0-x241.google.com with SMTP id f47-v6so2177722oth.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Apr 2018 11:28:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180406052116.31483-1-oohall@gmail.com>
References: <20180406052116.31483-1-oohall@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 6 Apr 2018 11:28:24 -0700
Message-ID: <CAPcyv4hRut3MjihCStXkO6QGXYQf6gmoPPmv_=9K-Z8qoVLL0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] libnvdimm: Add of_node to region and bus
 descriptors
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Thu, Apr 5, 2018 at 10:21 PM, Oliver O'Halloran <oohall@gmail.com> wrote:
> We want to be able to cross reference the region and bus devices
> with the device tree node that they were spawned from. libNVDIMM
> handles creating the actual devices for these internally, so we
> need to pass in a pointer to the relevant node in the descriptor.
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

These look good to me. I'll get them applied today and let them soak
over the weekend for a pull request on Monday.

If anyone wants to add Acks or Reviews I can append them to the merge
tag. If there are any NAKs please speak up now, but as far as I know
there are no pending device-tree design concerns.
