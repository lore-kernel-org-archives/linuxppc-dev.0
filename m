Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 8E8D3DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 01:11:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
Date: Tue, 17 Jul 2007 16:18:54 +0200
References: <469B33F9.2080604@windriver.com> <200707171506.43102.arnd@arndb.de>
	<1184682576.18501.62.camel@mark>
In-Reply-To: <1184682576.18501.62.camel@mark>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707171618.54903.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 17 July 2007, Mark Zhan wrote:
> 
> > Well, AFAICS, all of them currently use scc. The 8xx platforms don't
> > even build correctly in the mainline kernel, so I guess it would
> > be good to change them to also list fsl,cpm-smc in the compatible
> > property.
> 
> That probably could be done by another series of patches, and I really
> don't want to introduce those kinds of patches in my BSP patches. I
> don't know if the 8xx/82xx series patches from Scott Wood will cover
> this issue or not.

I guess he can best answer that himself. Scott, what are your plans
to deal with the different types of cpm ports?

	Arnd <><
