Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7C16BDDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 07:21:50 +1000 (EST)
Message-ID: <482CA963.20204@scram.de>
Date: Thu, 15 May 2008 23:21:39 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/8 v3] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
References: <20080515165250.GA30738@polina.dev.rtsoft.ru>
In-Reply-To: <20080515165250.GA30738@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Chen Gong <G.Chen@freescale.com>,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> - New patch supporting MPC8xx watchdogs (ok to drop until tested);

Unfortunately, current 2.6.26-rc2 doesn't boot at all on MPC823. I'll
have to bisect which patch broke it. I hope to have some testing results, soon.

Thanks,
Jochen
