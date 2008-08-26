Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A5299DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 07:28:20 +1000 (EST)
To: "Fillod Stephane" <stephane.fillod@thomson.net>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] RE: Some memory (DDR2 ECC Dual Rank) just doesn't work!
	Can anyone pointme to how to debug this hang?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <0B45E93C5FF65740AEAE690BF3848B7AD38359@rennsmail04.eu.thmulti.com>
References: <0B45E93C5FF65740AEAE690BF3848B7AD38359@rennsmail04.eu.thmulti.com>
Date: Tue, 26 Aug 2008 23:28:17 +0200
Sender: wd@denx.de
Message-Id: <20080826212817.E1B9D248C3@gemini.denx.de>
Cc: u-boot@lists.denx.de, Vince Asbridge <vasbridge@sanblaze.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Fillod,

In message <0B45E93C5FF65740AEAE690BF3848B7AD38359@rennsmail04.eu.thmulti.com> you wrote:
> 
> U-Boot is too gentle when testing SDRAM. Make sure the caches are enabled
> under U-Boot, and put on heavy stress with DMA, pipelined prefetch's, etc.
> This is what your CPU is enduring under Linux. =

Jon Loeliger thinks this will be fixed by Kumar's DDR patches that are
about to be checked in. Please test is this is correct, and report
back if it doesn't.

Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I'd rather be led to hell than managed to heaven.
