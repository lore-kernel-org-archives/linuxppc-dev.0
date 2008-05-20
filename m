Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0775EDECC6
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 05:42:06 +1000 (EST)
Message-ID: <483329AC.3000109@freescale.com>
Date: Tue, 20 May 2008 14:42:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: [PATCH] Fix cpm uart corruption with PREEMPT_RT
References: <20080520193917.C7ED15AF22@innovsys.com>
In-Reply-To: <20080520193917.C7ED15AF22@innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Fix CPM serial port corruption when running with CONFIG_PREEMPT_RT.
> Userland usage of console, and kernel printf's were stepping on each others toes.
> Also only take lock if not in an oops.
> 
> Signed-off-by: Rune Torgersen <runet@innovsys.com>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
