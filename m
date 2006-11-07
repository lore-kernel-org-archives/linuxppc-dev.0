Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40D4567D98
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 19:02:30 +1100 (EST)
In-Reply-To: <20061107072123.4463F67C29@ozlabs.org>
References: <20061107072123.4463F67C29@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E8EF524F-A90B-4B9E-B0F5-ABAC91815CDA@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/7] Add #defines for Hypertransport MSI fields
Date: Tue, 7 Nov 2006 09:01:03 +0100
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#define  HT_MSI_FIXED_ADDR	0x0000000FEE0000ULL	/* Fixed addr */

You forgot a zero at the end (and one on front, but that doesn't
matter all that much ;-) ).


Segher
