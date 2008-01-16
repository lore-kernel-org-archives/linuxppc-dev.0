Return-Path: <SRS0=9ZSp=SG=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id C739EDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 16:39:48 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH] net: EMAC: Fix problem with mtu > 4080 on non TAH
	equipped 4xx PPC's
Date: Wed, 16 Jan 2008 06:34:11 +0100
References: <1200400809-19720-1-git-send-email-sr@denx.de>
	<200801152046.01881.sr@denx.de>
	<20080115200019.GA2598@gate.ebshome.net>
In-Reply-To: <20080115200019.GA2598@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801160634.11745.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 January 2008, Eugene Surovegin wrote:
> > OK. But how do we detect GigE support? Seems like GigE enabled devices
> > have CONFIG_IBM_EMAC4 defined. If nobody objects I'll fix up another
> > version tomorrow.
>
> Look couple of lines down where I set MTU changing hook. If you cannot
> change MTU you cannot get big frames.

Ahhh, I must have been blind. Thanks for pointing out.

I'll send new patches for ibm_emac and ibm_newemac in a short while.

Best regards,
Stefan
