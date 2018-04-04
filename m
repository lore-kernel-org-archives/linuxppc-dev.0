Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x230.google.com (mail-pl0-x230.google.com
 [IPv6:2607:f8b0:400e:c01::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GQ5w0PKTzF1bP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 22:20:35 +1000 (AEST)
Received: by mail-pl0-x230.google.com with SMTP id 61-v6so11721647plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 05:20:35 -0700 (PDT)
Date: Wed, 4 Apr 2018 22:20:25 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: Re: [RESEND v2 4/4] powerpc/powernv: Create platform devs for
 nvdimm buses
Message-ID: <20180404222025.0de361ef@gmail.com>
In-Reply-To: <20180403142415.30083-4-oohall@gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
 <20180403142415.30083-4-oohall@gmail.com>
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

On Wed,  4 Apr 2018 00:24:15 +1000
Oliver O'Halloran <oohall@gmail.com> wrote:

> Scan the devicetree for an nvdimm-bus compatible and create
> a platform device for them.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
