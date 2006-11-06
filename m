Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A0E167C18
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 07:26:18 +1100 (EST)
Subject: Re: Can't build drivers/infiniband/hw/ipath/ipath_keys.c on
	arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adak628o6ua.fsf@cisco.com>
References: <1162798399.8175.24.camel@localhost.localdomain>
	<1162800409.28571.298.camel@localhost.localdomain>
	<adak628o6ua.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 07:24:01 +1100
Message-Id: <1162844641.28571.331.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: support@pathscale.com, openib-general <openib-general@openib.org>,
	Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 08:52 -0800, Roland Dreier wrote:
>  > I'm surprised that something as recent as infiniband requires a
>  > long-deprecated function bus_to_virt().
>  > 
>  > What is it trying to do there that needs that call ?
> 
> Don't ask -- just enjoy the fact that you don't know about this...

Deal :)

Ben.
