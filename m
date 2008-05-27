Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3CBEDDF92
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 07:02:16 +1000 (EST)
Message-ID: <483C771A.7050003@freescale.com>
Date: Tue, 27 May 2008 16:03:22 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
References: <850932.26140.qm@web83511.mail.sp1.yahoo.com>
In-Reply-To: <850932.26140.qm@web83511.mail.sp1.yahoo.com>
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
> In which function should I start searching for this
> problem?  What would cause a block to be marked bad?

No particular function; just something that causes things to not work. :-P

You may want to try increasing the OR[SCY] field or other timing 
parameters associated with the NAND flash.

-Scott
