Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC53CDE02D
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 07:00:14 +1000 (EST)
Date: Wed, 5 Sep 2007 16:00:08 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: OF NDFC
Message-ID: <20070905160008.201a243a@vader.jdub.homelinux.org>
In-Reply-To: <20070905181703.GA30904@ru.mvista.com>
References: <20070905181703.GA30904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Sep 2007 22:17:03 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Is anybody working on the device-tree-aware ppc 44x NAND flash controller (ndfc)  driver?

Not to my knowledge.  We sort of need a decent binding for NAND flash
in general first.  And David's recent flash binding doesn't address
NAND flash.

It's on my list of things to do, but if someone gets there first then
great.

josh
