Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 27968B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2012 05:51:09 +1000 (EST)
Message-ID: <1337975465.30100.4.camel@joe2Laptop>
Subject: Re: [PATCH] gianfar:don't add FCB length to hard_header_len
From: Joe Perches <joe@perches.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 25 May 2012 12:51:05 -0700
In-Reply-To: <20120525155820.GA25102@windriver.com>
References: <1337677248-27792-1-git-send-email-b06378@freescale.com>
 <20120522.151830.2018953337014839778.davem@davemloft.net>
 <4FBE4E02.1070306@computer.org> <1337876210.5070.4.camel@joe2Laptop>
 <20120525155820.GA25102@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, b06378@freescale.com, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, Jan Ceuleers <jan.ceuleers@computer.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-05-25 at 11:58 -0400, Paul Gortmaker wrote:
> But you really shouldn't need the hardware to validate this kind of
> patch anyways -- aside from your code flow change in the irq routine of
> gianfar_ptp, you should have been simply able to check for object file
> equivalence before and after your change.

No cross compiler either, and I'm lazy 'bout that...

cheers, Joe
