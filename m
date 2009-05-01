Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 885A6DDE2A
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 06:58:24 +1000 (EST)
Message-ID: <49FB61CA.9040305@freescale.com>
Date: Fri, 01 May 2009 15:55:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6] introduce macro spin_event_timeout()
References: <1240859144-20893-1-git-send-email-timur@freescale.com>
	<D823E17E-3066-45D5-A33D-539FA0883B55@kernel.crashing.org>
In-Reply-To: <D823E17E-3066-45D5-A33D-539FA0883B55@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> I wouldn't call it spin_event_timeout as its a bit too generic of a  
> name for something that is arch specific.

Well, I'm hoping it won't be arch-specific forever.  I'd like to see
other architectures implement something like tb_ticks_per_usec.  I'm
only tackling PowerPC for now.

-- 
Timur Tabi
Linux kernel developer at Freescale
