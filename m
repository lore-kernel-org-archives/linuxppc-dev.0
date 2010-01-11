Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BBFC6B7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:44:19 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0BJiFHV026984 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 12:44:16 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0BJo8Qk003209
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 13:50:08 -0600 (CST)
Message-ID: <4B4B7F13.3090809@freescale.com>
Date: Mon, 11 Jan 2010 13:42:11 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 02/13] powerpc/5200: LocalPlus driver: use SCLPC register
	structure
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>	<200912220759.23453.roman.fietze@telemotive.de>
	<fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
In-Reply-To: <fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Please don't.  I know that a lot of other 5200 code uses register map
> structures in this way, but I consider it bad practice.  I coded this
> driver without a structure for a reason.  The reason I haven't removed
> the other 5200 register map structures is the code impact would be
> huge, it would probably cause breakage, and it would break all
> out-of-tree patches touching the same code for no measurable
> advantage.

FWIW, over on the U-Boot side patches are getting NACKed by Wolfgang if 
they don't use register structures. :-P

They're nice from a type-safety and namespacing perspective, though they 
get ugly pretty quickly if there are gaps.

-Scott
