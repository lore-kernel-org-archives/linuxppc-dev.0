Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CED1BDDEF9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 06:29:07 +1000 (EST)
Date: Tue, 8 Jul 2008 15:28:47 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "mike zheng" <mail4mz@gmail.com>
Subject: Re: Freescale SEC driver with cryptoloop on MPC8567e
Message-Id: <20080708152847.6a248104.kim.phillips@freescale.com>
In-Reply-To: <5c9cd53b0807081103y583d0013ic0d22fb46490be2b@mail.gmail.com>
References: <5c9cd53b0807081103y583d0013ic0d22fb46490be2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 Jul 2008 14:03:28 -0400
"mike zheng" <mail4mz@gmail.com> wrote:

> Hello,
> 
> Any one know how can I integrate the Freescale's SEC driver with
> cryptoloop in Kernel2.4 on MPC8567e? Or which version of kernel shall
> I take if it is already there?

Take Herbert's cryptodev-2.6 tree and add support in the talitos driver
for the ablkcipher algorithm you're using.

Kim
