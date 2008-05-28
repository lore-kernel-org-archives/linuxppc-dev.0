Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0AAADDF3B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 04:41:45 +1000 (EST)
Message-ID: <483DA7AB.4090009@freescale.com>
Date: Wed, 28 May 2008 13:42:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
References: <80364.25515.qm@web83512.mail.sp1.yahoo.com>
In-Reply-To: <80364.25515.qm@web83512.mail.sp1.yahoo.com>
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

Ron Madrid wrote:
> --- Scott Wood <scottwood@freescale.com> wrote:
>> You may want to try increasing the OR[SCY] field or
>> other timing 
>> parameters associated with the NAND flash.
> 
> So are you saying that when this happened in the past
> it was a timing issue?  This change would need to
> happen in u-boot correct?

Well, there was a bug that accidentally changed SCY from 1 to 0. :-P

U-boot would be the ideal place to fix it, but if you're only accessing 
the flash from Linux, it could be changed in platform code.

-Scott
