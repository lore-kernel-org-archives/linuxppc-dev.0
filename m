Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F2D7A2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 08:50:54 +1100 (EST)
Date: Tue, 8 Oct 2013 23:42:08 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1] powerpc/mpc512x: silence build warning upon disabled
 DIU
Message-ID: <20131008234208.456c8e84@crub>
In-Reply-To: <1380295718-10700-1-git-send-email-gsi@denx.de>
References: <1380295718-10700-1-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 27 Sep 2013 17:28:38 +0200
Gerhard Sittig <gsi@denx.de> wrote:

> a disabled Kconfig option results in a reference to a not implemented
> routine when the IS_ENABLED() macro is used for both conditional
> implementation of the routine as well as a C language source code test
> at the call site -- the "if (0) func();" construct only gets eliminated
> later by the optimizer, while the compiler already has emitted its
> warning about "func()" being undeclared

applied, thanks!
