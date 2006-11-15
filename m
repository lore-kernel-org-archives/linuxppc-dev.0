Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCA9667CBF
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:56:40 +1100 (EST)
Subject: Re: [PATCH 14/16] Resource assignments for PCI devices on Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200611150958.kAF9wXTQ011153@toshiba.co.jp>
References: <200611150958.kAF9wXTQ011153@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 10:56:36 +1100
Message-Id: <1163634996.5940.293.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-15 at 18:58 +0900, Ishizaki Kou wrote:
> Celleb has multiple PCI buses. Devices on some of those PCI buses require to
> assign resources by Linux. 
> This patch is for such buses not to claim resources, because claimed resource
> does not become a target for resource assign.

I do not fully understand why you need that. You should be able to let
the PCI code claim all resources wether they are on real PCI or not.

Ben.
