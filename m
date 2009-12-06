Return-Path: <roffermanns@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [195.145.229.155])
	by ozlabs.org (Postfix) with ESMTP id C0E21B7BDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Dec 2009 19:30:20 +1100 (EST)
Subject: Re: TQM5200 + SM501 FB
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Rolf Offermanns <roffermanns@sysgo.com>
In-Reply-To: <20091204220426.ADD063F6E3@gemini.denx.de>
Date: Sun, 6 Dec 2009 09:30:17 +0100
Message-Id: <F5B2E7AE-A0C5-4D9B-AF8F-3158B94D6236@sysgo.com>
References: <20091204220426.ADD063F6E3@gemini.denx.de>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 04.12.2009 um 23:04 schrieb Wolfgang Denk:

> Please find attached below a patch which fixes some issues (but we
> don't consider it clean enough for inclusion into mainline yet), and a
> known to be working config file. [Kudos to Anatolij for providing
> this.]
>=20

Thanks Wolfgang, I will try it on monday. What needs to be done to get =
this into mainline?

Modify the sm501 stuff for fdt and extend the tqm5200.dts file with the =
sm501 resources?

-Rolf=
