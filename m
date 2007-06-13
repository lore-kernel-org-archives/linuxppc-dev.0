Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75D4DDDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 18:28:02 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l5D8RvIL001481
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:27:58 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5D8RuM4024540
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 03:27:57 -0500 (CDT)
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <26a24ad5f123db79f880f8c53cf2c71f@kernel.crashing.org>
References: <1181717615.9397.40.camel@localhost.localdomain>
	<6dc1593b8ff8442f7b4cf7a01f69c07c@kernel.crashing.org>
	<1181718898.12936.6.camel@localhost.localdomain>
	<cad6a9b0bd58df6298cb5f8402e512e7@kernel.crashing.org>
	<1181720633.12936.19.camel@localhost.localdomain>
	<26a24ad5f123db79f880f8c53cf2c71f@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181723251.13195.4.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 16:27:31 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-13 at 15:54, Segher Boessenkool wrote:
[snip]
> 
> > If it does not matter, I'd like to put them in one line :-).
> 
> Current thinking on this seems to be that long literal strings
> are fine.  You are right that some people might challenge you
> on this, of course ;-)
Then, I will say Segher tell me to do that ...
Roy
