Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id B90DF67B83
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 16:19:40 +1000 (EST)
Date: Fri, 20 Oct 2006 08:19:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
Message-ID: <20061020061934.GA3735@aepfle.de>
References: <20061019122802.GA26637@aepfle.de> <45377ED3.9030001@bplan-gmbh.de>
	<1161308221.10524.92.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1161308221.10524.92.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, Benjamin Herrenschmidt wrote:

> On CHRP with only a 8259, make sure it's set as the default host.

No errors with this patch.
