Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3992DDFB8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Mar 2008 05:28:54 +1100 (EST)
Date: Tue, 18 Mar 2008 13:28:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: =?utf-8?B?6YOt5Yqy?= <guojin02@tsinghua.org.cn>
Subject: Re: Hi,friends, the question about the u-boot and device tree?
Message-ID: <20080318182840.GA4235@loki.buserror.net>
References: <405422271.18508@tsinghua.org.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <405422271.18508@tsinghua.org.cn>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 13, 2008 at 11:31:11PM +0800, 郭劲 wrote:
> I make all the frequency(timebase-frequency;bus-frequency;clock-frequency) value
> on device tree file equal to zero, I think those frequency will filled by u-boot
> during bootm, but in fact, the u-boot did not fill any frequency. after bootm,
> crashed. Why?

What board?  Are you using a device-tree-aware u-boot and the three-argument
form of bootm?  What sort of crash?  How do you know it's not filling in the
frequencies?

> Why so many document point out that the zero value will be filled by u-boot?

Because it does. :-)
If it's not doing so on your board, that needs to be fixed.

-Scott
