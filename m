Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5F75DDE24
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 03:46:29 +1000 (EST)
Message-ID: <4703D568.6000000@pobox.com>
Date: Wed, 03 Oct 2007 13:46:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [9/11] pasemi_mac: clear out old errors on interface open
References: <20071002212421.GA2282@lixom.net> <20071002212739.GJ2282@lixom.net>
In-Reply-To: <20071002212739.GJ2282@lixom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> pasemi_mac: clear out old errors on interface open
> 
> Clear out any pending errors when an interface is brought up. Since the bits
> are sticky, they might be from interface shutdown time after firmware has
> used it, etc.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

In general, interface-open should completely reset and initialize the 
hardware.  does pasemi_mac not do that?

	Jeff
