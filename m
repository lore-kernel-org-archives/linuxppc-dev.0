Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64896B7CF6
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Apr 2010 14:54:06 +1000 (EST)
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Gatliff <bgat@billgatliff.com>
In-Reply-To: <4BC682DC.1050200@billgatliff.com>
References: <4BC682DC.1050200@billgatliff.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Apr 2010 14:53:47 +1000
Message-ID: <1271307227.13059.156.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-14 at 22:07 -0500, Bill Gatliff wrote:
> 
> Anyone have any suggestions on where to start with this one?  Anyone
> else running a similar configuration with any success?  I'm completely
> lost, and running out of hair *fast*...

Most probably endian bugs in the Lime driver ...

Cheers,
Ben.
