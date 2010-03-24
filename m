Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC6D3B7CBB
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 20:44:01 +1100 (EST)
Subject: Re: Linux patches for XIP on MPC8xx?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20100323194401.0B7724C022@gemini.denx.de>
References: <4BA865D4.1090403@freemail.hu>
	<20100323194401.0B7724C022@gemini.denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Mar 2010 20:43:24 +1100
Message-ID: <1269423804.8599.217.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Wolfgang Grandegger <wg@denx.de>,
	=?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-03-23 at 20:44 +0100, Wolfgang Denk wrote:
> There were very few tests done with later kernel versions, and in all
> practical system configurations we tested we found that XIP did not
> give real benefits. Usually execution from flash was slower than when
> running from RAM, and even booting a (inevitably uncompressed) kernel
> from flash is typically slower than loading a compressed image to RUM
> and booting from there.
                                                                     ^

Missing an H here :-)

Cheers,
Ben.
