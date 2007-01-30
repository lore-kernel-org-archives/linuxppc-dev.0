Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1AC8DDFE4
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:54:10 +1100 (EST)
In-Reply-To: <20070129201208.GJ13485@ld0162-tx32.am.freescale.net>
References: <20070129201208.GJ13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EBA70DCA-527B-4804-848D-11EB56E907F9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/18] bootwrapper: Add ft_find_device_rel().
Date: Tue, 30 Jan 2007 20:53:57 +0100
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

> +void *ft_find_device_rel(struct ft_cxt *cxt, const void *top,
> +                         const char *srch_path)
> +{
> +	char *node;
> +
> +	node = ft_node_ph2node(cxt, top);

Huh -- are phandles a pointer?  Why not just a u32?
Or is _your_ code buggy ;-)  [No it's not, I checked]


Segher
