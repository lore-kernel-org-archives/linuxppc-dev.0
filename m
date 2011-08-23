Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A98CCB6F9D
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2011 02:12:24 +1000 (EST)
Message-ID: <4E53D15D.2050807@freescale.com>
Date: Tue, 23 Aug 2011 11:12:13 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>	<4E4D3CE0.7020602@freescale.com>
	<4E5366AF.7040108@freescale.com> <4E537AC4.6000301@parrot.com>
In-Reply-To: <4E537AC4.6000301@parrot.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	LiuShuo <b35362@freescale.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2011 05:02 AM, Matthieu CASTET wrote:
> LiuShuo a =C3=A9crit :
>> We can't read the NOP from the ID on any chip. Some chips don't
>> give this infomation.(e.g. Micron MT29F4G08BAC)

Are there any 4K+ chips (especially ones with insufficient NOP) that
don't have the info?

This chip is 2K and NOP8.

Is there an easy way (without needing to have every datasheet for every
chip ever made) to determine at runtime which chips supply this informati=
on?

> Doesn't the micron chip provide it with onfi info ?

This chip doesn't appear to be ONFI.

-Scott
