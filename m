Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BEF6CDDEF1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 15:14:37 +1000 (EST)
Message-ID: <48647736.3080704@garzik.org>
Date: Fri, 27 Jun 2008 01:14:30 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH V2] ibm_newemac: Fixes kernel crashes when speed of cable
	connected changes
References: <1214246162-25293-1-git-send-email-sr@denx.de>
In-Reply-To: <1214246162-25293-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sathya Narayanan <sathyan@teamf1.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> From: Sathya Narayanan <sathyan@teamf1.com>
> 
> The descriptor pointers were not initialized to NIL values, so it was
> poiniting to some random addresses which was completely invalid. This
> fix takes care of initializing the descriptor to NIL values and clearing
> the valid descriptors on clean ring operation.
> 
> Signed-off-by: Sathya Narayanan <sathyan@teamf1.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> Changed since V1:
> - Fixed off-by-one error in for loops
> 
>  drivers/net/ibm_newemac/core.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

I didn't see any answers to ben h's questions?

Holding this patch, waiting for ben's ack...
