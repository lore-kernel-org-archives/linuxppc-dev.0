Return-Path: <ralf@linux-mips.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by lists.ozlabs.org (Postfix) with ESMTP id A8AF91A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 18:26:48 +1000 (AEST)
Received: from localhost.localdomain ([127.0.0.1]:37599 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S27026923AbbFCI0qa3D7P (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Wed, 3 Jun 2015 10:26:46 +0200
Date: Wed, 3 Jun 2015 10:26:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Grant Likely <grant.likely@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: clean-up unnecessary libfdt include paths
Message-ID: <20150603082638.GJ9839@linux-mips.org>
References: <1433308225-13874-1-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433308225-13874-1-git-send-email-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 03, 2015 at 12:10:25AM -0500, Rob Herring wrote:
> Date:   Wed,  3 Jun 2015 00:10:25 -0500
> From: Rob Herring <robh@kernel.org>
> To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
>  Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt
>  <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
>  Ellerman <mpe@ellerman.id.au>, linux-mips@linux-mips.org,
>  linuxppc-dev@lists.ozlabs.org
> Subject: [PATCH] of: clean-up unnecessary libfdt include paths
> 
> With the latest dtc import include fixups, it is no longer necessary to
> add explicit include paths to use libfdt. Remove these across the
> kernel.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org

For the MIPS bits;

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
