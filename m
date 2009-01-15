Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 18582DE2CA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 18:26:51 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so388784ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 23:26:50 -0800 (PST)
Message-ID: <fa686aa40901142326y8a314k41a0fee6b3e6ffe5@mail.gmail.com>
Date: Thu, 15 Jan 2009 00:26:50 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Michael Ellerman" <michael@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc: Remove printk-only progress implementations
In-Reply-To: <32db977796782e4d132edb123a64b2437e5ea830.1232001793.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
	<32db977796782e4d132edb123a64b2437e5ea830.1232001793.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 14, 2009 at 11:43 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> Several platforms implement ppc_md.progress as a simple printk. Now that
> we have the ppc_progress() wrapper which falls back to printk if no
> routine is specified, we can remove all the printk-only progress
> implementations.
>
> This leaves us with iSeries_progress(), rtas_progress() and udbg_progress().
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
