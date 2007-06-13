Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19E9CDDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 16:44:26 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5D6iMQi023720
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 23:44:22 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5D6iKTL012080
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:44:21 -0500 (CDT)
Subject: Re: [PATCH v3]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1181715851.9397.22.camel@localhost.localdomain>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<1181639293.8953.7.camel@localhost.localdomain>
	<f81c6f149f20c52f547f39ca0cc8d67c@kernel.crashing.org>
	<1181713501.9397.10.camel@localhost.localdomain>
	<1181715851.9397.22.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1181717035.9397.30.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 14:43:56 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-13 at 14:24, Zang Roy-r61911 wrote:
> From: roy zang <tie-fei.zang@freescale.com>
> 
> Fix the reset bug on 8548CDS board.
> >From MPC8548CDS with e500 v2 core, a new reset control register is
> added.
I am also curious who adds the extra symbol ">" before From, the
mailer(I am using evolution) or else ...
:-)
Roy
