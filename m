Return-Path: <rjwalsh@pathscale.com>
Received: from mx.pathscale.com (mx.pathscale.com [64.160.42.68])
	by ozlabs.org (Postfix) with ESMTP id DACE467C0C
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 19:11:34 +1100 (EST)
Message-ID: <454EE778.2030109@pathscale.com>
Date: Sun, 05 Nov 2006 23:42:48 -0800
From: Robert Walsh <rjwalsh@pathscale.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [openib-general] Can't build
	drivers/infiniband/hw/ipath/ipath_keys.c on arch/powerpc
References: <1162798399.8175.24.camel@localhost.localdomain>
In-Reply-To: <1162798399.8175.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: support@pathscale.com, Andrew Morton <akpm@osdl.org>,
	openib-general <openib-general@openib.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Hi,
> 
> Just a heads-up, drivers/infiniband/hw/ipath/ipath_keys.c doesn't build
> on powerpc because we have don't have bus_to_virt().
> 
> (Actually you can't select CONFIG_INFINIBAND_IPATH on mainline because
> powerpc doesn't enable PCI_MSI, but we will real soon now, and when we
> do this will start breaking people's all modconfig builds).

Thanks for the heads-up.  We're working to remove this requirement as we 
speak.

Regards,
  Robert.
