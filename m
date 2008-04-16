Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 61D83DE745
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:10:49 +1000 (EST)
Message-ID: <48066B54.30309@freescale.com>
Date: Wed, 16 Apr 2008 16:10:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: lseek() on entries in /proc/device-tree returns EINVAL
References: <48066857.4030109@freescale.com>
	<062501c8a006$27b17b90$771472b0$@Tjernlund@transmode.se>
In-Reply-To: <062501c8a006$27b17b90$771472b0$@Tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:

> Yeah, just reported a similar problem at LKML. busybox start-stop-daemon broke
> between 2.6.23 and current tree. The change was intentional but the borkage
> was not. Al Viro has been informed, lets see what comes of it.

I've changed my code to use fstat() instead, which is better for my purposes anyway.

-- 
Timur Tabi
Linux kernel developer at Freescale
