Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24FA41A0BC9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 11:58:41 +1100 (AEDT)
Message-ID: <1424307520.22020.5.camel@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc/mpic: remove unused functions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arseny Solokha <asolokha@kb.kras.ru>
Date: Thu, 19 Feb 2015 11:58:40 +1100
In-Reply-To: <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-16 at 17:56 +0700, Arseny Solokha wrote:
> Drop unused fsl_mpic_primary_get_version(), mpic_set_clk_ratio(),
> mpic_set_serial_int().

I'm always happy to remove unused code, but the interesting question is why are
they unused? Please tell me in the changelog.

cheers
