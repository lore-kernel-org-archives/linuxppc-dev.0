Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x22b.google.com (mail-ot0-x22b.google.com
 [IPv6:2607:f8b0:4003:c0f::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40793l11WYzF1cd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 04:08:35 +1100 (AEDT)
Received: by mail-ot0-x22b.google.com with SMTP id t2-v6so14008918otj.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 10:08:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323081209.31387-4-oohall@gmail.com>
References: <20180323081209.31387-1-oohall@gmail.com>
 <20180323081209.31387-4-oohall@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 23 Mar 2018 10:08:32 -0700
Message-ID: <CAPcyv4i2vXN6ib6Ofs0f-hRG93wZ3jYyBHEGQZXOqk9CprPmGw@mail.gmail.com>
Subject: Re: [PATCH 4/6] libnvdimm/of: Symlink platform and region devices
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Device Tree <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2018 at 1:12 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
> Add a way direct link between the region and the platform device that
> creates the region.
>

This linking would not be needed if of_nd_regions each lived on their own bus.
