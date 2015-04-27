Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB65C1A08C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 19:54:23 +1000 (AEST)
Message-ID: <1430128435.16571.110.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Mon, 27 Apr 2015 19:53:55 +1000
In-Reply-To: <553DE41A.5070703@samsung.com>
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com> <20150423161342.55e9ac8f@ja.home>
 <1430086038.16571.78.camel@kernel.crashing.org>
 <553DE41A.5070703@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, rpurdie@rpsys.net,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-04-27 at 09:24 +0200, Jacek Anaszewski wrote:
> I was not aware that some other entity than the driver could be
> interested in the information provided by DT node. I will no longer
> object, provided that we will get an ack from DT maintainer.

My understanding is that we no longer need bindings to be accepted by DT
maintainers.

That being said, I would like to review this one before it is accepted,
as I haven't had a chance to do so yet :-) (I was mostly responding to
you, I haven't caught up with the full thread yet).

Please wait for an ack from myself or Michael Ellerman (the two powerpc
maintainers). Either that or provide your ack and we'll merge it via our
tree if we are happy with it.

Cheers,
Ben.
