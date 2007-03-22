Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 699DEDE087
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 03:22:34 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2MGMTdq000467
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 09:22:29 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2MGMSuo029398
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 11:22:28 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2MG2WLQ016325
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 11:02:33 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id CECD5AEFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 11:22:27 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2MGMRDA020608
	for linuxppc-dev@ozlabs.org; Thu, 22 Mar 2007 11:22:27 -0500
Date: Thu, 22 Mar 2007 11:22:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Remove bogus errors from check_chosen.
Message-ID: <20070322162227.GA20544@ld0162-tx32.am.freescale.net>
References: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 11:11:09AM -0500, Scott Wood wrote:
> It is not an error for /chosen (or any of its children) to be missing.
> 
> It is not a requirement that the output of dtc be a complete, valid
> device tree, as it may be intended that the dtb be passed through boot
> code that will complete it.  Thus, do not complain.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  livetree.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)

Obviously, this is a DTC patch, and not a kernel patch.
I forgot to label it as such.

-Scott
