Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408Y811D09zF1wh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 10:17:04 +1100 (AEDT)
Received: by mail-pf0-x22e.google.com with SMTP id u86so1045562pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 16:17:04 -0700 (PDT)
Date: Mon, 26 Mar 2018 10:16:47 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linux-nvdimm@lists.01.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/6] libnvdimm: Add of_node to region and bus descriptors
Message-ID: <20180326101647.07673304@gmail.com>
In-Reply-To: <20180323081209.31387-1-oohall@gmail.com>
References: <20180323081209.31387-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 23 Mar 2018 19:12:04 +1100
Oliver O'Halloran <oohall@gmail.com> wrote:

> We want to be able to cross reference the region and bus devices
> with the device tree node that they were spawned from. libNVDIMM
> handles creating the actual devices for these internally, so we
> need to pass in a pointer to the relevant node in the descriptor.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
