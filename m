Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7960FDDE32
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 11:16:16 +1000 (EST)
Message-ID: <47156258.5010800@garzik.org>
Date: Tue, 16 Oct 2007 21:16:08 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: Fix new EMAC driver for NAPI changes
References: <1192513250.19073.10.camel@pasglop>
In-Reply-To: <1192513250.19073.10.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org,
	Roland Dreier <rdreier@cisco.com>, "David S. Miller" <davem@davemloft.net>,
	shemminger@linux.foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> net: Fix new EMAC driver for NAPI changes
> 
> This fixes the new EMAC driver for the NAPI updates. The previous patch
> by Roland Dreier (already applied) to do that doesn't actually work. This
> applies on top of it makes it work on my test Ebony machine.
> 
> This patch depends on "net: Add __napi_sycnhronize() to sync with napi poll"
> posted previously.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> The old EMAC driver does things a bit differently (doesn't do useful
> locking :-) and seems to work with Roland patch. So I'm not going to
> touch it unless somebody reports me that it has problems

applied
