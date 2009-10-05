Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFE47B7B93
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 08:46:19 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n95LkGXY019409
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 14:46:16 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n95LmVgL010544
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 16:48:31 -0500 (CDT)
Message-ID: <4ACA6943.9020500@freescale.com>
Date: Mon, 05 Oct 2009 16:46:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<20091005181233.GA3576@loki.buserror.net>	
	<OF44D5E829.2889B774-ONC1257646.00645628-C1257646.006568EE@transmode.se>	
	<20091005200941.GD3576@loki.buserror.net>	
	<OFFC147C60.2DA4B63D-ONC1257646.00733843-C1257646.0073CFFD@transmode.se>
	<1254778299.7122.39.camel@pasglop>
	<OF17005BC2.01F7F762-ONC1257646.0076C3C3-C1257646.00772EBF@transmode.se>
In-Reply-To: <OF17005BC2.01F7F762-ONC1257646.0076C3C3-C1257646.00772EBF@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/10/2009 23:31:39:
> 
>>> Yes, every ld.so uses dcbX and icbi insn when relocatin code.
>> Even with -msecure-plt ?
> 
> hmm, maybe not. Can't remember now. But perhaps LAZY relocs still
> need dcbX? Easiest is to check in uClibc. I impl. it, but was to long
> time ago for me to remember. Scott are you using uClibc? I don't
> think so because of the dynamic check of the cache line size

No, this is glibc.

-Scott
