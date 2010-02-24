Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F87BB7CF3
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 05:49:26 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1OInN1C020152
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 11:49:23 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o1OIvEJt011167
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 12:57:14 -0600 (CST)
Message-ID: <4B85746F.3020200@freescale.com>
Date: Wed, 24 Feb 2010 12:48:15 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com>
In-Reply-To: <4B854A93.7030405@mlbassoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gary Thomas wrote:
> Does anyone have experience setting up the PCI controller on
> the MPC8349?  I have it running fine when my system has 128MB
> or less of main memory, but when I have 256MB or more, it all
> falls apart :-(
> 
> Any indication of the pertinent settings would be appreciated.

Check the inbound PCI translation registers, especially PIWARn.

-Scott
