Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 820A81A10A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:38:25 +1100 (AEDT)
Date: Wed, 9 Mar 2016 00:38:18 -0600
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20160309063818.GA10069@home.buserror.net>
References: <1457423952-13014-1-git-send-email-alessio.bogani@elettra.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457423952-13014-1-git-send-email-alessio.bogani@elettra.eu>
Subject: Re: [1/1] powerpc/embedded6xx: Make reboot works on MVME5100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2016 at 08:59:12AM +0100, Alessio Igor Bogani wrote:
> The mtmsr() function hangs during restart. Make reboot works on
> MVME5100 removing that function call.
> ---
>  arch/powerpc/platforms/embedded6xx/mvme5100.c | 2 --
>  1 file changed, 2 deletions(-)

Missing signoff

Do you know why MSR_IP was there to begin with?  Does this board have a
switch that determines whether boot vectors are high or low (I remember
some 83xx boards that did), in which case is this fixing one config by
breaking another?

-Scott
