Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 825D8DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 07:02:31 +1100 (EST)
In-Reply-To: <20070129201307.GP13485@ld0162-tx32.am.freescale.net>
References: <20070129201307.GP13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E87F75BF-81BC-4440-AFFD-10CD9DF783C7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 16/18] bootwrapper: Add dt_ops methods.
Date: Tue, 30 Jan 2007 21:01:17 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static void *ft_finddevice_rel(const void *phandle, const char *name)
> +{
> +	return ft_find_device_rel(&cxt, phandle, name);
> +}

Seeing all these...  wouldn't it be better to make "cxt"
an implicit parameter to all the ft_ functions?  It's not
like you'll ever be dealing with more than one tree ;-)


Segher
