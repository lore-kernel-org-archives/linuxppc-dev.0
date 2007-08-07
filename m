Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9264DDECD
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 07:46:28 +1000 (EST)
Message-ID: <46B8E82E.5080107@garzik.org>
Date: Tue, 07 Aug 2007 17:46:22 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/6] ibmveth: Enable TCP checksum offload
References: <11864293333377-patch-mail.ibm.com>
In-Reply-To: <11864293333377-patch-mail.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, rcjenn@linux.vnet.ibm.com,
	santil@linux.vnet.ibm.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King wrote:
> This patchset enables TCP checksum offload support for IPV4
> on ibmveth. This completely eliminates the generation and checking of
> the checksum for packets that are completely virtual and never
> touch a physical network. A simple TCP_STREAM netperf run on
> a virtual network with maximum mtu set yielded a ~30% increase
> in throughput. This feature is enabled by default on systems that
> support it, but can be disabled with a module option.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>

ACK, but does not apply to current netdev-2.6.git#upstream-fixes. 
Request resend after the ibmveth fixes hit mainline (24 hours or so 
after push, I suppose)
