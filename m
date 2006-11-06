Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id BA67967C5E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 03:53:47 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Can't build drivers/infiniband/hw/ipath/ipath_keys.c on
	arch/powerpc
References: <1162798399.8175.24.camel@localhost.localdomain>
	<1162800409.28571.298.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Nov 2006 08:52:45 -0800
In-Reply-To: <1162800409.28571.298.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 06 Nov 2006 19:06:48 +1100")
Message-ID: <adak628o6ua.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > I'm surprised that something as recent as infiniband requires a
 > long-deprecated function bus_to_virt().
 > 
 > What is it trying to do there that needs that call ?

Don't ask -- just enjoy the fact that you don't know about this...
