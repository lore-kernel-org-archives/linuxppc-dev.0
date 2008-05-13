Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3FB7DDF06
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 00:50:50 +1000 (EST)
Message-Id: <8C355C2C-C029-4F02-A5B0-DA8173FAFF69@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080513141411.GA8981@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 0/6 v2] mpc83xx_wdt rework, support for mpc8610
Date: Tue, 13 May 2008 09:50:26 -0500
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 13, 2008, at 9:14 AM, Anton Vorontsov wrote:

> Hi all,
>
> Thanks for the review, here is the new version.
>
> Changes since v1:
>
> - Scott Wood asked for mpc83xx_wdt on multiplatform kernels. Done via
>  OF platform driver;
> - Kumar Gala asked for mpc83xx_wdt -> mpc8xxx_wdt rename. Done in two
>  steps;
> - Segher Boessenkool noticed a negligence in the wdt device tree node.
>  Fixed by removing mpc83xx_wdt compatible entry.

any possibility of making this work on 8xx per Jochen's comment?  (see  
mpc8xx_wdt.c)

- k
