Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD68DDE14C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 06:18:19 +1000 (EST)
Message-ID: <48766E4D.5060607@freescale.com>
Date: Thu, 10 Jul 2008 15:17:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
References: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
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

Paul Gortmaker wrote:
> The mpc7448hpc2 board doesn't have an alias block like
> most of the other modern eval boards have.  We need this
> block in order to have u-boot be able to make use of the
> CONFIG_OF_STDOUT_VIA_ALIAS (vs. having a hard coded node)
> in the future.
> 
> Also remove the old, redundant chosen node.  Of all the modern
> Freescale eval boards (incl. 83xx, 85xx, 86xx) this is the only
> one which still has it.  Its presence also breaks with some older
> versions of u-boot, like 1.3.1 -- which try and insert a
> second chosen node.

The chosen node is still required for output from the cuboot wrapper.

-Scott
