Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7120FB6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jul 2011 06:27:52 +1000 (EST)
Received: from mail138-va3 (localhost.localdomain [127.0.0.1])	by
	mail138-va3-R.bigfish.com (Postfix) with ESMTP id BFCABA500BD	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2011 20:27:47 +0000 (UTC)
Date: Wed, 27 Jul 2011 15:27:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: <naresh.kamboju@wipro.com>
Subject: Re: HELP:PowerPc-Linux kernel
Message-ID: <20110727152741.5975ad71@schlenkerla.am.freescale.net>
In-Reply-To: <35CC4C9595855B43903A67B297EFA8E3C544FD@HYD-MKD-MBX01.wipro.com>
References: <35CC4C9595855B43903A67B297EFA8E3C544FD@HYD-MKD-MBX01.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jul 2011 20:33:54 +0530
<naresh.kamboju@wipro.com> wrote:

> Hi,
> 
>  
> 
> I have take up the new assignment  Board bring up activity with Linux
> kernel on PowerPC MPC8272.
> 
> I have been searching Linux bring up on PowerPC processor in Google and
> IBM wiki and not found good stuff.
> 
> It would be more helpful for me if you could share related documents.

Look at the support in current kernels for 82xx-based boards such as
mpc8272ads.  Read the documentation on device trees
(Documentation/devicetree, devicetree.org, ePAPR).

-Scott
