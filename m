Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A08EDDF14
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 05:26:17 +1100 (EST)
Message-ID: <4798D838.9090809@freescale.com>
Date: Thu, 24 Jan 2008 12:26:00 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v5 0/5] device_type/compatible cleanups
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124173511.GA16288@localhost.localdomain>
In-Reply-To: <20080124173511.GA16288@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Heh. `git-format-patch --stdout -5 | diffstat` doesn't work correctly.
> Once I've already stumbled against this, but obviously forgot.

Might try:

    git diff --stat HEAD~4

or such!

Enjoy,
jdl
