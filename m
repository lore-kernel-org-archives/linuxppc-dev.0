Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4223B7093
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 05:08:15 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBAI8CHH001668
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 11:08:13 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nBAIDJXm001724
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 12:13:19 -0600 (CST)
Message-ID: <4B2138E1.5080609@freescale.com>
Date: Thu, 10 Dec 2009 12:07:29 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 0/3] powerpc/83xx: Sleep and deep sleep support for
	MPC8315E-RDB
References: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
In-Reply-To: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Hi all,
> 
> This is quite late resend, sorry.
> 
> Only the third patch has changed, i.e. I got rid of sleep-nexus
> stuff per Scott and Benjamin suggestions.

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
