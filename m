Return-Path: <jgarzik@pobox.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D30CA67A72
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 19:48:57 +1100 (EST)
Message-ID: <4216FD64.9020509@pobox.com>
Date: Sat, 19 Feb 2005 03:48:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <20050218101245.D11439@cox.net>
In-Reply-To: <20050218101245.D11439@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] emac: filter illegal frame sizes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter wrote:
> Fix to drop frames that are too large for the current MTU.

What is this fixing?

You should be passing all frames up to the software stack.

	Jeff
