Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D070FDE0E9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:04:44 +1100 (EST)
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <1227638045-12862-1-git-send-email-gerickson@nuovations.com>
References: <1227638045-12862-1-git-send-email-gerickson@nuovations.com>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 11:04:02 +1100
Message-Id: <1231286642.14860.35.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Wolfgang Denx <wd@denx.de>, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-11-25 at 10:34 -0800, Grant Erickson wrote:
> This merges support for the previously DENX-only kernel feature of
> specifying an alternative, "external" buffer for kernel printk
> messages and their associated metadata. In addition, this ports
> architecture support for this feature from arch/ppc to arch/powerpc.
> 
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>

Considering the extensive changes to generic code, this patch will
have to be submitted via the linux-kernel mailing list.

I suggest you split the generic core change from the powerpc specific
implementation.

I'm not sure whether I like the idea myself or not there, so you'll have
to convince the powers that be to take it.

Cheers,
Ben.
