Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wX5YJ4xgxzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 16:42:12 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id d127so37066040wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 23:42:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 23 May 2017 08:42:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 5/6] mm, x86: Add ARCH_HAS_ZONE_DEVICE
Message-ID: <20170523064206.g4275jdoj3mtbf4o@gmail.com>
References: <20170523040524.13717-1-oohall@gmail.com>
 <20170523040524.13717-5-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170523040524.13717-5-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Oliver O'Halloran <oohall@gmail.com> wrote:

> Currently ZONE_DEVICE depends on X86_64. This is fine for now, but it
> will get unwieldly as new platforms get ZONE_DEVICE support. Moving it
> to an arch selected Kconfig option to save us some trouble in the
> future.
> 
> Cc: x86@kernel.org
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
