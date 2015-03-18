Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B65E1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 15:47:35 +1100 (AEDT)
Message-ID: <1426654054.6504.2.camel@ellerman.id.au>
Subject: Re: [PATCH] Revert "of: Fix premature bootconsole disable with
 'stdout-path'"
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Hurley <peter@hurleysoftware.com>
Date: Wed, 18 Mar 2015 15:47:34 +1100
In-Reply-To: <1426625193-5055-1-git-send-email-peter@hurleysoftware.com>
References: <1426625193-5055-1-git-send-email-peter@hurleysoftware.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Grant Likely <grant.likely@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-17 at 16:46 -0400, Peter Hurley wrote:
> This reverts commit 2fa645cb2703d9b3786d850db815414dfeefa51d.
> 
> The assumption that at least 1 preferred console will be registered
> when the stdout-path property is set is invalid, which can result
> in _no_ consoles.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Grant/Rob, in case you didn't see it, this has caused a panic on at least one
powerpc box. So would be nice if it could go in for 4.0.

cheers
