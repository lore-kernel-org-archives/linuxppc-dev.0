Return-Path: <glikely@secretlab.ca>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BB61A0D99
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 18:25:02 +1000 (AEST)
Received: by payr10 with SMTP id r10so25031341pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2015 01:25:01 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: clean-up unnecessary libfdt include paths
To: Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20150603082638.GJ9839@linux-mips.org>
References: <1433308225-13874-1-git-send-email-robh@kernel.org>
 <20150603082638.GJ9839@linux-mips.org>
Date: Thu, 04 Jun 2015 17:02:10 +0900
Message-Id: <20150604080210.B6467C40D75@trevor.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 3 Jun 2015 10:26:38 +0200
, Ralf Baechle <ralf@linux-mips.org>
 wrote:
> On Wed, Jun 03, 2015 at 12:10:25AM -0500, Rob Herring wrote:
> > Date:   Wed,  3 Jun 2015 00:10:25 -0500
> > From: Rob Herring <robh@kernel.org>
> > To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> > Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
> >  Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt
> >  <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
> >  Ellerman <mpe@ellerman.id.au>, linux-mips@linux-mips.org,
> >  linuxppc-dev@lists.ozlabs.org
> > Subject: [PATCH] of: clean-up unnecessary libfdt include paths
> > 
> > With the latest dtc import include fixups, it is no longer necessary to
> > add explicit include paths to use libfdt. Remove these across the
> > kernel.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> 
> For the MIPS bits;
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
>   Ralf


Acked-by: Grant Likely <grant.likely@lianro.org>
