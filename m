Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11B5BDE3FE
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 01:57:55 +1000 (EST)
Message-ID: <48174544.70107@freescale.com>
Date: Tue, 29 Apr 2008 10:56:52 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] devres: support addresses greater than an unsigned long
	via dev_ioremap
References: <Pine.LNX.4.64.0804290122210.10928@blarg.am.freescale.net>	<4816C094.6030601@gmail.com>
	<4816C214.60806@pobox.com>
	<C415A4D5-CE5A-4E48-B5D5-0B9A6C7A5CA6@kernel.crashing.org>
In-Reply-To: <C415A4D5-CE5A-4E48-B5D5-0B9A6C7A5CA6@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> Its a pretty trivial 
> patch and would be nice to go into 2.6.26.  I would also consider it a 
> bug fix of shorts for any driver

Looked like a bugfix of longs to me... :-)

jdl
