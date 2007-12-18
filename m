Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF83BDDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 02:11:02 +1100 (EST)
Date: Tue, 18 Dec 2007 18:10:07 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] [POWERPC] Add fixed-phy support for fs_enet
Message-ID: <20071218181007.5ac05511@kernel.crashing.org>
In-Reply-To: <4767042E.2070903@garzik.org>
References: <47601027.2080104@scram.de>
	<4767042E.2070903@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Dec 2007 18:20:14 -0500
Jeff Garzik wrote:

> Jochen Friedrich wrote:
> > This patch adds support to use the fixed-link property
> > of an ethernet node to fs_enet for the
> > CONFIG_PPC_CPM_NEW_BINDING case.
> > 
> > Signed-off-by: Jochen Friedrich <jochen@scram.de>
Acked-by: Vitaly Bordug <vitb@kernel.crashing.org>

Jochen,
will you resend the patch with all acks to paulus? I'll do that if not.


-- 
Sincerely, Vitaly
