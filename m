Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15349DDEED
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 12:20:22 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m6B2KF4H003355
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 19:20:16 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m6B2KDp4002496
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 21:20:14 -0500 (CDT)
Subject: Re: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
From: Roy Zang <tie-fei.zang@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
References: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain
Date: Fri, 11 Jul 2008 10:17:31 +0800
Message-Id: <1215742651.25390.0.camel@rock.ap.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-11 at 04:21 +0800, Paul Gortmaker wrote:
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
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com> 
> --- 
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
Roy
