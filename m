Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 145A5B6F86
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 09:13:19 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Date: Tue, 21 Jun 2011 23:13:11 +0000
Message-ID: <4E012586.7050808@freescale.com>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker>
In-Reply-To: <20110622003853.1041385c@wker>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: sun york-R58495 <R58495@freescale.com>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"lethal@linux-sh.org" <lethal@linux-sh.org>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij Gustschin wrote:
> No! We are using ioctl interface of this driver in many video
> rendering applications on overlay planes on huge number of boards.
> So, please don't remove it.

Ok, I had no idea anyone was using it.

Can you email me details about how you use the ioctl interface?  If I can't=
=20
remove it, maybe I can clean it up.

--=20
Timur Tabi
Linux kernel developer at Freescale=
