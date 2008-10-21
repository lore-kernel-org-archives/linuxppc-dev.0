Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D532BDDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 17:00:45 +1100 (EST)
Subject: Re: device tree variations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Ditto <mditto@consentry.com>
In-Reply-To: <48F9466D.8060603@consentry.com>
References: <48F7E1E6.4040701@consentry.com>
	<20081017012604.GA22213@yookeroo.seuss>
	<48F9466D.8060603@consentry.com>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 17:00:35 +1100
Message-Id: <1224568835.7654.234.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Thanks.  The fdt_del_node approach works pretty nicely.  I added a
> dt_ops hook since fdt is static in libfdt-wrapper.c.

 .../...

David says your patch is ok, However it's not in the right form. Could
you repost it please with a proper changeset comment and signed-off-by:
line ?

Thanks !

Cheers,
Ben.
