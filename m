Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D9A9567EC5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 06:56:34 +1100 (EST)
Date: Mon, 13 Nov 2006 13:56:09 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC] Draft mpc52xx device tree specification
Message-Id: <20061113135609.601647b0.kim.phillips@freescale.com>
In-Reply-To: <528646bc0611130047v107e7171h804c674534ef8058@mail.gmail.com>
References: <528646bc0611130047v107e7171h804c674534ef8058@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jrigby@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Nov 2006 01:47:29 -0700
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> 
> This document specifies the requirements on the device-tree for mpc52xx
> based boards.  These requirements are above and beyond the details
> specified in the booting-without-of.txt document.

well, the definition of the compatible property has a different bias.  I'm not saying the definition in booting-without-of is necessarily better (I know the document is too linux- and freescale-specific in places), I'm just saying that this document has good ideas, but is creating an unnecessary diversion, and amending booting-without-of would help maintain consistency with other platforms' efforts.

Kim
