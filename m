Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-223-245.roch.qwest.net
	[71.36.223.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C82568436
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Oct 2005 03:49:35 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
In-Reply-To: <1128095076.15236.15.camel@mephisto.spb.rtsoft.ru>
References: <1128095076.15236.15.camel@mephisto.spb.rtsoft.ru>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 12:49:21 -0500
Message-Id: <1128102561.3111.6.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3]MTD driver for Yucca board
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-09-30 at 19:44 +0400, Ruslan V. Sushko wrote:
> This patch adds MTD driver for Yucca ppc440SPe board. The patch
> implemented for Roland Dreier git tree for Yucca 440SPe board

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ruslan V. Sushko <rsushko@ru.mvista.com>");
> +MODULE_DESCRIPTION("MTD map and partitions for IBM 440SPe Yucca boards");

Nit: I think you mean "AMCC 440SPe Yucca boards".  IBM no longer makes
reference boards for 4xx hardware.

josh
