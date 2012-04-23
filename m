Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B843B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 03:32:31 +1000 (EST)
Received: by dang27 with SMTP id g27so19977266dan.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 10:32:30 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] powerpc/mpic: Fix confusion between hw_irq and virq
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <1334892574.31646.0.camel@pasglop>
References: <1334892574.31646.0.camel@pasglop>
Date: Mon, 23 Apr 2012 11:32:28 -0600
Message-Id: <20120423173228.BA05A3E089A@localhost>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Apr 2012 13:29:34 +1000, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> mpic_is_ipi() takes a virq and immediately converts it to a hw_irq.
> 
> However, one of the two call sites calls it with a ... hw_irq. The
> other call site also happens to have the hw_irq at hand, so let's
> change it to just take that as an argument. Also change mpic_is_tm()
> for consistency.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks good to me.  Are you pushing these up to Linus for v3.4?

g.
